// product review model
const mongoose = require("mongoose");

const reviewSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },
  product: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product"
  },
  message: {
    type: String
  }
});

const review = mongoose.model("Comment", reviewSchema);
module.exports = review;
