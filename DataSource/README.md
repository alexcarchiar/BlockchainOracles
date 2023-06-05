# Data source 

## Description
Data source for the blockchain oracles used in this project
For a detailed description of the use case, see the paper.

The Data source simulates a centralized source for an inbound blockchain oracle.
The oracle queries information from the website and provides it to the blockchain.
The scenario that is being simulated is that of a news/media company, that provides
flash news on its website through an API. A user of the blockchain oracle wants
to query the latest flash news.

The pieces of news in both the Data source and design documents will be referred to as
"posts" or "articles" interchangeably.

An article is a json object defined as:
```
{
  title: String,
  description: String
}
```

The Data source is a Proof of Concept that provides a very simple API with three requests:
- GET /posts - Provides all of the posts that are on database
- POST /posts - Allows one to submit a new article to the WebApp
- GET /posts/latest - Allows one to get the latest article that was submitted to the WebApp

The paper focuses on some of the security aspects for blockchain oracles, thus the Data source
is barebones and has very limited functionality. This is because Web development and 
security of Web Applications is not part of the research, thus DO NOT USE this code in any
production environment.

For example, with the way the app is designed, anyone can submit new articles to the 
Data source database. This is of course problematic, but it is not a concern for our 
purposes.

## Technologies

The technologies used for this Data source are:
- Node.js / npm to create and manage the app
- MongoDB Atlas is used as a Database
- Mongoose.js to interact with MongoDB from the app
- Express.js to manage Middlewares and Routes
- Cors.js to allow interacting with the app form any IP
- Body-parser.js to parse the HTTP requests and responses
- Dotenv.js to deal with environment variables
- Nodemon.js to run the app in a test environment
- Render.com to deploy the app and manage CI/CD
- This Github repository for CI/CD

## How to run

In order to run the app, you need to have Node.js and npm with the latest update available
at the time this document was written: `9.3.1`

You also need your own MongoDB database, otherwise you will not be able to use the API.

Once you download this repository, you need to run `npm install` and `npm start` to run it
in a test environment using Nodemon.

You need to create a `.env` file where you have the variable `DB_CONNECTION` set to the 
URL of your personal database.

The app will run on `localhost:3000`.

## Demo

One demo is available here: https://data-source.onrender.com

The homepage just shows a `We are on home` line.
You can check that the API works as defined above.
