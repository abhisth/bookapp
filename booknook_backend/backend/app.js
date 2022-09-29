//app js edited
const express = require('express')
const cors = require("cors")
const mongoose = require("mongoose")
const morgan = require("morgan")

const userRoutes = require("./routes/user.route.js")
const productRoutes = require("./routes/product.route.js")

const app = express()
app.use(cors())
app.use(morgan("tiny"))
app.use(express.json())
app.use(express.urlencoded({extended:false}))
app.use("/public", express.static('public'))

app.use(userRoutes)
app.use(productRoutes)

mongoose.connect('mongodb://localhost:27017/booknookdb').then(()=>{
        app.listen(80,()=>{
            console.log(`Server Started`)
        })
}).catch((err)=>{
    console.log(err)
})