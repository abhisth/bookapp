// user controller
const User = require("../models/user.js");
const Order = require("../models/order.js");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

module.exports.register_user = async function (req, res) {
  const { firstname, lastname, email, password, contact, address, profile } =
    req.body;
  const salt = await bcrypt.genSalt(10);
  const hashed = await bcrypt.hash(password, salt);
  const user = new User({
    firstname,
    lastname,
    email,
    contact,
    address,
    password: hashed,
    profile:
      "https://w7.pngwing.com/pngs/419/473/png-transparent-computer-icons-user-profile-login-user-heroes-sphere-black-thumbnail.png",
  });
  await user.save();
  res.json({ message: "User Registered", success: true });
};

module.exports.login_user = async function (req, res) {
  const user = await User.findOne({ email: req.body.email });
  if (user) {
    const validLogin = await bcrypt.compare(req.body.password, user.password);
    if (validLogin) {
      const _id = user._id;
      let isAdmin = false;
      if (user.userType == "Admin") {
        isAdmin = true;
      }
      const accessToken = jwt.sign({ _id }, "token");
      return res.json({
        message: "User Login.",
        accessToken,
        isAdmin: isAdmin,
        data: user,
        success: true,
      });
    } else {
      return res.json({ msg: "Invalid Credential", success: false });
    }
  } else {
    return res.json({ msg: "Invalid Credential", success: false });
  }
};

module.exports.register_admin = async function (req, res) {
  const { firstname, lastname, email, password, contact, address, profile } =
    req.body;
  const salt = await bcrypt.genSalt(10);
  const hashed = await bcrypt.hash(password, salt);
  const user = new User({
    firstname,
    lastname,
    email,
    contact,
    address,
    password: hashed,
    userType: "Admin",
    profile,
  });
  await user.save();
  return res.json({ message: "User Registered", success: true });
};

module.exports.login_admin = async function (req, res) {
  const user = await User.findOne({ email: req.body.email });
  if (user) {
    const validLogin = await bcrypt.compare(req.body.password, user.password);
    if (validLogin) {
      const _id = user._id;
      const accessToken = jwt.sign({ _id }, "token");
      return res.json({
        message: "Admin Login.",
        isAdmin: true,
        accessToken: accessToken,
        data: user,
        success: true,
      });
    } else {
      return res.json({ message: "Invalid Credential", success: false });
    }
  } else {
    return res.json({ message: "Invalid Credential", success: false });
  }
};

module.exports.get_user_detail = async function (req, res) {
  const _id = req.user._id;
  const user = await User.findById(_id).populate("cart");
  res.json({ success: true, message: "User Fetched", data: user });
};

module.exports.update_user = async function (req, res) {
  const { firstname, lastname, phoneNumber, address, contact } = req.body;
  const user = req.user;
  await User.updateOne(
    { _id: user._id },
    { firstname, lastname, phoneNumber, address, contact }
  );
  return res.json({ message: "User Profile Updated", success: true });
};

module.exports.update_user_picture = async function (req, res) {
  if (req.file == undefined) {
    return res.json({ message: "only png files are allowed!" });
  }
  const filename = req.file.filename;
  const user = req.user;
  const result = await User.updateOne(
    { _id: user._id },
    {
      profile: "http://localhost:80/public/" + filename,
    }
  );
  res.json({ message: "User Profile Picture Uploaded", success: true });
};

module.exports.add_to_cart = async function (req, res) {
  const user = req.user;
  const productId = req.params.id;
  let message;
  const doesItemExistOnCart = user.cart.find(function (item) {
    if (item._id == productId) {
      return true;
    }
  });
  if (doesItemExistOnCart) {
    user.cart.pop(productId);
    message = "Product Removed from cart";
  } else {
    user.cart.push(productId);
    message = "Product Added to cart";
  }
  await user.save();
  res.json({ message, success: true });
};

module.exports.view_cart = async function (req, res) {
  const user = req.user;
  const cart = user.cart;
  console.log(cart);
  res.json({ message: "View Cart", success: true, data: cart });
};

module.exports.checkout_cart = async function (req, res) {
  const cart = req.body.cart;
  const user = req.user;
  if (user.cart.length != 0) {
    // user.cart.clear();
    const order = new Order({
      user: user._id,
      items: cart,
    });
    await order.save();
    await user.save();
  }
  res.json({ message: "Order Placed Successfully", success: true, data: cart });
};
