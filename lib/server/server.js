const admin = require("firebase-admin");
const express = require("express");
const bodyParser = require("body-parser");

const serviceAccount = require("./serviceAccountKey.json");
const port = process.env.PORT || 3000;

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(bodyParser.json());

// API gửi notification
app.post("/sendNotification", async (req, res) => {
  try {
    const { token, notification, data } = req.body;

    const message = {
      token: token,
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

app.listen(port, () => {
  console.log(`Notification server running on port ${port}`);
});