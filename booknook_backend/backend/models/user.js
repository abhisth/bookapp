// user model
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    firstname: {
      type: String,
      required: true,
    },
    lastname: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
      match: [
        /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
        "Please fill a valid email address",
      ],
    },
    password: {
      type: String,
      required: true,
    },
    contact: {
      type: String,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    userType: {
      type: String,
      enum: ["Admin", "User"],
      default: "User",
    },
    profile: {
      type: String,
    },
    cart:[
      {
          type: mongoose.Schema.Types.ObjectId,
          ref: "Product"
      }
  ],
});

const user = mongoose.model("User", userSchema);
module.exports = user;
