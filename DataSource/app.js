const express = require('express')
const mongoose = require('mongoose')
require('dotenv/config')
const bodyParser = require('body-parser')
const postsRoute = require('./Routes/posts')
const cors = require('cors')

const app = express()

app.use(cors())
app.use(bodyParser.json())

app.use('/posts', postsRoute)

app.get('/', (req,res) => {
        response = "<p>We are on the homepage. Go to /posts to see all posts, go to /posts/latest to see the latest one</p>"
        response += "<p>Public key is:</p>"
        //26
        public_key = process.env.PUBLIC_KEY
        arr = [
            "-----BEGIN PUBLIC KEY-----",
            "MFYwEAYHKoZIzj0CAQYFK4EEAA",
            "oDQgAEq+K8bD8Lidlwc58aHJiS",
            "ZHTnVIHSdlRq NgdaKMS2hHFpy",
            "JH0GCGRO9cXx+EtpC++rF9XAW0",
            "/c3CtXQmlNavxnw== ",
            "-----END PUBLIC KEY-----"
        ]
        for(let i = 0; i<7; i++){
            response += "<p>" + arr[i] + "</p>"
            //response += arr[i] + "\n"
        }
        res.send(response)
    }
)

//connect to db
mongoose.set('strictQuery', false)
try {
    mongoose.connect(
        process.env.DB_CONNECTION,
    () => console.log('connected to db'))
} catch(e) {
    console.log(e)
}

const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
    console.log(`server started on port ${PORT}`)
})


