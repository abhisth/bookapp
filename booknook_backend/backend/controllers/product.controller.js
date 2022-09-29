//product controller
const Product = require("../models/product.js")
const Comment = require("../models/comment");
const product = require("../models/product.js");

module.exports.add_product = async function (req, res) {
    const {name, author, description, category, price} = req.body
    const product = new Product({name, author,description, category, price})
    await product.save()
    res.json({message: "Product Added", success: true, data : product._id})
};

module.exports.upload_image = async function (req, res) {
    if (req.file == undefined) {
      return res.json({ message: "only png files are allowed!" });
    }
    const filename = req.file.filename;
    await Product.updateOne(
      { _id: req.params.id },
      {
        image: "http://localhost:80/public/" + filename,
      }
    );
    res.json({ message: "Image Uploaded", success: true });
};

module.exports.update_product = async function (req,res){
    const {name, author, description, category, price} = req.body
    await Product.updateOne(
        { _id: req.params.id },
        { name, author, description, category, price }
    );
    res.json({ message: "Product Updated", success: true });
}

module.exports.delete_product = async function (req,res){
    await Product.deleteOne({ _id: req.params.id });
    res.json({ message: "Product Deleted", success: true });
}

module.exports.view_product = async function (req,res){
    const product = await Product.findOne({ _id: req.params.id });
    res.json({ message: "Product Fetched", success: true, data: product });
}

module.exports.get_products = async function (req,res){
    const product = await Product.find();
    res.json({ message: "All Product Fetched", success: true, data: product });
}

module.exports.get_comments = async function (req,res){
    const productId = req.params.id
    const comment = await Comment.find({product: productId});
    res.json({ message: "All Product Fetched", success: true, data: comment });
}

module.exports.write_comment = async function (req,res){
    const productId = req.params.id
    const comment = new Comment({
        user: req.user._id,
        product: productId,
        message: req.body.message
    })
    await comment.save()
    res.json({ message: "Comment Inserted", success: true});
}

module.exports.edit_comment = async function (req,res){
    const commentId = req.params.id
    const user = req.user._id
    await Comment.updateOne(
        {_id: commentId, user: user},
        {
            message: req.body.message
        }
    )
    res.json({ message: "Comment Edited", success: true});
}

module.exports.delete_comment = async function (req,res){
    const commentId = req.params.id
    const user = req.user._id
    await Comment.deleteOne({_id: commentId, user: user})
    res.json({ message: "Comment Deleted", success: true});
}