//product model
const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    author: {
        type: String,
    },
    description: {
        type: String,
    },
    category: {
        type: String,
    },
    image: {
        type: String,
    },
    price: {
        type: Number,
    },
});

const product = mongoose.model("Product", productSchema);
module.exports = product;
