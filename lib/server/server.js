const admin = require("firebase-admin");
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");
const cors = require("cors");

const port = process.env.PORT || 3000;

// Load service account từ Environment Variable (Render)
const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(bodyParser.json());
app.use(cors());

// PayPal credentials
const CLIENT_ID =
  "AVKSKHNJojK5a1z0zEoM22lpmeOsdb86gihpJ4X6WBi66PuB9ryeIMdhEDCwBsAVupXgjD6bRf_oKBv-";
const SECRET =
  "EDmZZfK6SKEpQZDH2VlScOYTs9yZbqmq5O9vvkuTTuh0Ha6YT6F9QBqzPu18rrFuxYWkalDih8ZAHpVb";
const PAYPAL_API = "https://api-m.sandbox.paypal.com"; // Sandbox endpoint

// Get PayPal access token
async function getAccessToken() {
  const response = await axios({
    url: `${PAYPAL_API}/v1/oauth2/token`,
    method: "post",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    auth: { username: CLIENT_ID, password: SECRET },
    data: "grant_type=client_credentials",
  });
  console.log("AccessToken:", response.data.access_token); // 👈 log thử
  return response.data.access_token;
}

// Create order
app.post("/create-order", async (req, res) => {
  try {
    const { amount, productName } = req.body;
    const accessToken = await getAccessToken();

    const response = await axios({
      url: `${PAYPAL_API}/v2/checkout/orders`,
      method: "post",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${accessToken}`,
      },
      data: {
        intent: "CAPTURE",
        purchase_units: [
          {
            amount: {
              currency_code: "USD",
              value: amount,
            },
          },
        ],
        application_context: {
          return_url: "http://localhost:3000/success",
          cancel_url: "http://localhost:3000/cancel",
        },
      },
    });

    console.log("PayPal order response:", response.data); // 👈 LOG ĐỂ KIỂM TRA
    res.json(response.data);
  } catch (error) {
    console.error(
      "Error creating order:",
      error.response?.data || error.message
    );
    res.status(500).send({ error: error.message });
  }
});

// Capture order
app.post("/capture-order/:orderID", async (req, res) => {
  try {
    const { orderID } = req.params;
    const accessToken = await getAccessToken();

    const response = await axios({
      url: `${PAYPAL_API}/v2/checkout/orders/${orderID}/capture`,
      method: "post",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${accessToken}`,
      },
    });

    res.json(response.data);
  } catch (error) {
    console.error(
      "Error capturing order:",
      error.response?.data || error.message
    );
    res.status(500).send({ error: error.message });
  }
});

// Send Firebase notification
app.post("/sendNotification", async (req, res) => {
  try {
    const { token, notification, data } = req.body;

    if (!token || !notification?.title || !notification?.body) {
      return res.status(400).send({ success: false, error: "Missing fields" });
    }

    const message = {
      token,
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: data || {},
    };

    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
    res.status(200).send({ success: true, response });
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).send({ success: false, error: error.message });
  }
});

app.get("/", (req, res) => {
  res.send("Firebase Cloud Messaging Server is running.");
});

app.listen(port, () => {
  console.log(`http://localhost:${port}/`);
});
