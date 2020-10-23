const express = require('express');
const app = express();
const jwt = require('express-jwt');
const jwtAuthz = require('express-jwt-authz');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const { Pool, Client } = require('pg');
require('dotenv').config();

if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
  throw 'Make sure you have AUTH0_DOMAIN, and AUTH0_AUDIENCE in your .env file';
}

const corsOptions =  {
  origin: 'https://hermes-delivery-hub.herokuapp.com'
};

app.use(cors(corsOptions));
app.use(express.json());

const checkJwt = jwt({
  // Dynamically provide a signing key based on the [Key ID](https://tools.ietf.org/html/rfc7515#section-4.1.4) header parameter ("kid") and the signing keys provided by the JWKS endpoint.
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json/`
  }),

  // Validate the audience and the issuer.
  audience: process.env.AUTH0_AUDIENCE,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256']
});

const checkScopes = jwtAuthz(['read:messages']);

app.get('/api/public', function(req, res) {
  res.json({
    message: 'Hello from a public endpoint! You don\'t need to be authenticated to see this.'
  });
});

app.get('/api/private', checkJwt, function(req, res) {
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated to see this.'
  });
});

app.get('/api/private-scoped', checkJwt, checkScopes, function(req, res) {
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.'
  });
});


app.use(function(err, req, res, next){
  console.log(req.headers)
  console.error(err.stack);
  return res.status(err.status).json({ message: err.message });
});

//Connecting the database to the backend
//Connecting to the database so we can query it, etc.
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'hermes',
  password: 'a',
  port: 5432,
})

client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'hermes',
    password: 'adidas123',
    port: 5432,
});

//JS isnt an OOP language, so getting this class I created onto another file might be tricky. For now, it can live here.
class ezQueryBuilder {
    getUsersFromCompany(companyName){
      return "SELECT u.* FROM CompanyRelations cr, Users u, Company c WHERE cr.userId = u.userId AND c.compId = cr.compId AND c.compName = '" + companyName + "';"
    }

    getAllCompanies(){
      return 'SELECT compName FROM Company;';
    }

    getAUsersPackages(username){
      return "SELECT p.* FROM Users u, PackageRelations pr, Package p WHERE pr.userId = u.userId AND pr.packageId = p.packageId AND u.userName = '" + username + "';";
    }

    getACompanysPackages(companyName){
      return "SELECT p.* FROM Company c, PackageRelations pr, CompanyRelations cr, Package p WHERE c.compName = '" + companyName + "' AND c.compId = cr.compId AND pr.userId = cr.userId AND pr.packageId = p.packageId;";
    }

    getACustomersPackages(username){
      return "SELECT p.* FROM CustomerToPackage ctp, Users u, Package p WHERE u.userName = '" + username + "' AND ctp.userId = u.userId AND p.packageId = ctp.packageId;"
    }

    updateUsersAddress(username, address){
      return "UPDATE Users SET address = '" + address + "' WHERE userName = '"+ username +"';"
    }

    updatePackageStartingLocation(location, packageId){
      return "UPDATE Package SET packageSLocation = '" + location + "' WHERE packageId = '" + packageId + "';"
    }

    updatePackageEndingLocation(){
      return "UPDATE Package SET packageELocation = '" + location + "' WHERE packageId = '" + packageId + "';"
    }

    updatePackageDeliveryStatus(packageDeliveryStatus, packageId){
      return "UPDATE Package SET packageDeliveryStatus = '" + packageDeliveryStatus + "' WHERE packageId = '" + packageId + "';"
    }

    insertNewUser(fname, lname, username, pass, role, add){
      return "INSERT INTO USERS(fname, lname, username, userpassword, roleid, address) VALUES (" + fname + " , " + lname + " , " + username + " , " + pass + " , " + role + " , " + add + ");"
    }

    /*
    updateUserAffiliation(){

    }

    updateUsersPackageStatus(){

    }
    */
}

//Example here...
let easyQB = new ezQueryBuilder();

client.connect()
// client.query(easyQB.updatePackageStartingLocation('00001','Radio, Somewhere'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   //client.end()
// })
// client.query(easyQB.getUsersFromCompany("Vees Viral Shippers"), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   //client.end()
// })

app.post('/api/profile', checkJwt, function(req, res) {
  client.query(easyQB.insertNewUser(req.body.fname, req.body.lname, req.body.username, req.body.userpassword, req.body.roleid, req.body.address), (err, res) => {
      console.log(res)
    })
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated to see this.'
  });
});

app.get('/api/company', checkJwt, function(req, res) {
  client.query(easyQB.getAllCompanies(), (err, res) => {
      console.log(res)
    })
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated to see this.'
  });
});

app.listen(process.env.PORT || 5000);