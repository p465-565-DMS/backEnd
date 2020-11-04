const express = require('express');
const app = express();
const jwt = require('express-jwt');
const jwtAuthz = require('express-jwt-authz');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const { get_jwt_claims } = require('./utils/jwtClaims');
const { Pool, Client } = require('pg');
require('dotenv').config();

if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
  throw 'Make sure you have AUTH0_DOMAIN, and AUTH0_AUDIENCE in your .env file';
}

const corsOptions =  {
  origin: ['https://hermes-delivery-hub.herokuapp.com','http://localhost:3000']
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
// const pool = new Pool({
//   user: 'postgres',
//   host: 'localhost',
//   database: 'hermes',
//   password: 'a',
//   port: 5432,
// })

client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'hermes',
    password: 'postgres',
    port: 5432,
});
client.connect()

//JS isnt an OOP language, so getting this class I created onto another file might be tricky. For now, it can live here.
class ezQueryBuilder {
    getUsersFromCompany(companyName){
      console.log("SELECT DISTINCT u.* FROM CompanyRelations cr, Users u, Company c WHERE cr.userId = u.userId AND c.compId = cr.compId AND c.compName = '" + companyName + "';");
      return "SELECT DISTINCT u.* FROM CompanyRelations cr, Users u, Company c WHERE cr.userId = u.userId AND c.compId = cr.compId AND c.compName = '" + companyName + "';"
    }

    getAllCompanies(){
      console.log('SELECT DISTINCT compName FROM Company;');
      return 'SELECT DISTINCT compName FROM Company;';
    }

    getAUsersPackages(username){
      console.log("SELECT DISTINCT p.* FROM Users u, PackageRelations pr, Package p WHERE pr.userId = u.userId AND pr.packageId = p.packageId AND u.userName = '" + username + "';");
      return "SELECT DISTINCT p.* FROM Users u, PackageRelations pr, Package p WHERE pr.userId = u.userId AND pr.packageId = p.packageId AND u.userName = '" + username + "';";
    }

    getACompanysPackages(companyName){
      console.log("SELECT DISTINCT p.* FROM Company c, PackageRelations pr, CompanyRelations cr, Package p WHERE c.compName = '" + companyName + "' AND c.compId = cr.compId AND pr.userId = cr.userId AND pr.packageId = p.packageId;")
      return "SELECT DISTINCT p.* FROM Company c, PackageRelations pr, CompanyRelations cr, Package p WHERE c.compName = '" + companyName + "' AND c.compId = cr.compId AND pr.userId = cr.userId AND pr.packageId = p.packageId;";
    }

    getACustomersPackages(username){
      console.log("SELECT DISTINCT p.* FROM CustomerToPackage ctp, Users u, Package p WHERE u.userName = '" + username + "' AND ctp.userId = u.userId AND p.packageId = ctp.packageId;");
      return "SELECT DISTINCT p.* FROM CustomerToPackage ctp, Users u, Package p WHERE u.userName = '" + username + "' AND ctp.userId = u.userId AND p.packageId = ctp.packageId;"
    }

    getUser(email){
      return "SELECT * FROM Users WHERE email = '"+email+"';"
    }

    getUserId(email){
      return "SELECT userid FROM Users WHERE email = '"+email+"';"  
    }

    getCompany(uid){
      return "SELECT companyname FROM deliveryadmin WHERE userid = '"+uid+"';"
    }

    getEmployee(cname){
      return "SELECT DISTINCT u.fname, u.lname, u.email, u.username, u.role, u.googlelink FROM users u, deliveryadmin da, deliverydriver dd WHERE dd.companyname ='"+cname+"' AND dd.userid = u.userid;"
    }
    updateUser(email, fname, lname, phone, streetAddress, city, state, zipcode, googlelink){
      return "UPDATE Users SET fname = '"+fname+"', lname = '"+lname+"', phone = '"+phone+"', address = '"+streetAddress+"', city = '"+city+"', state = '"+state+"', zipcode = '"+zipcode+"', googlelink = '"+googlelink+"' WHERE email = '"+email+"';";
    }
    updateUsersAddress(username, address){
      console.log("UPDATE Users SET address = '" + address + "' WHERE userName = '"+ username +"';")
      return "UPDATE Users SET address = '" + address + "' WHERE userName = '"+ username +"';"
    }

    updatePackageStartingLocation(packageId, location){
      console.log("UPDATE Package SET packageSLocation = '" + location + "' WHERE packageId = " + packageId + ";");
      return "UPDATE Package SET packageSLocation = '" + location + "' WHERE packageId = " + packageId + ";"
    }

    updatePackageEndingLocation(packageId, location){
      console.log("UPDATE Package SET packageELocation = '" + location + "' WHERE packageId = " + packageId + ";");
      return "UPDATE Package SET packageELocation = '" + location + "' WHERE packageId = " + packageId + ";"
    }

    updatePackageDeliveryStatus(packageId, packageDeliveryStatus){
      console.log("UPDATE Package SET packageDeliveryStatus = '" + packageDeliveryStatus + "' WHERE packageId = " + packageId + ";")
      return "UPDATE Package SET packageDeliveryStatus = '" + packageDeliveryStatus + "' WHERE packageId = " + packageId + ";"
    }

    createACompany(compName, creatorId, logo, description, address){
      return "INSERT INTO Company (compName, creatorId, logo, description, address) VALUES ('" + compName + "', " + creatorId + ", '" + logo + "', '" + description +"', '" + address + "')";
    }

    createAUser(fname, lname, username, role, address, phone, email, state, city, link, zipcode){
      console.log("INSERT INTO Users (fname, lName, userName, role, address, phone, email, state, city, googlelink, zipcode) VALUES ('"+fname+"', '"+lname+"', '"+username+"', '"+role+"', '"+address+"', '"+phone+"', '"+email+"', '"+state+"', '"+city+"', '"+link+"', '"+zipcode +"');");
      return "INSERT INTO Users (fname, lName, userName, role, address, phone, email, state, city, googlelink, zipcode) VALUES ('"+fname+"', '"+lname+"', '"+username+"', '"+role+"', '"+address+"', '"+phone+"', '"+email+"', '"+state+"', '"+city+"', '"+link+"', '"+zipcode +"');";
    }

    createAnAdmin(username, cname, spkg, mpkg, lpkg, elec, deli, heavy, doc, other, express, normal){
      return "INSERT INTO deliveryAdmin(userid, companyname, spkg, mpkg, lpkg, electronic, delicate, heavy, doc, other, express, normal) VALUES((SELECT userid from users where username='"+username+"'), '"+cname+"','"+spkg+"','"+mpkg+"','"+lpkg+"','"+elec+"','"+deli+"','"+heavy+"','"+doc+"','"+other+"','"+express+"','"+normal+"');";
    } 

    createADriver(username, cname, lno){
      return "INSERT INTO deliverydriver(userid, companyname, licenseno) VALUES((SELECT userid from users where username='"+username+"'),'"+cname+"','"+lno+"');";
    }
    createUserRelationToCompany(compId, userId){
      return "INSERT INTO CompanyRelations VALUES ("+compId +", "+userId+");";
    }

    createAPackage(title, desc, sloc, deadline, eloc, status){
      return "INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus) VALUES ('"+title+"','"+desc+"','"+sloc+"','"+deadline+"','"+eloc+"', '"+status+"');";
    }

    createAPackageRelation(userid, packageid){
      return "INSERT INTO PackageRelations VALUES ('"+userid +"', '"+packageid+"');";
    }

    createACustomerToPackageRelation(userid, packageid){
      return "INSERT INTO CustomerToPackage VALUES ('"+userid +"', '"+packageid+"');";
    }

    getPackageCurrentLocation(packageId){
      return "SELECT currentLocation FROM Package WHERE packageId = " + packageId;
    }

    getAllCompanyCustomers(compName){
      return "SELECT DISTINCT customers.* FROM CustomerToPackage ctp, PackageRelations pr, Users u, CompanyRelations cr, Company c, Users customers WHERE ctp.packageId = pr.packageId AND pr.userId = u.userId AND u.userId = cr.userId AND cr.compId = c.compId AND customers.userId = ctp.userId AND c.compName = "+"'"+compName+"';"
    }

    getAUsersPackagesThatAreDelivered(username){
      return "SELECT DISTINCT p.* FROM Users u, PackageRelations pr, Package p WHERE pr.userId = u.userId AND p.packageDeliveryStatus = 'DELIVERED' AND pr.packageId = p.packageId AND u.userName = '" + username + "';";
    }


}

//Example here...
let easyQB = new ezQueryBuilder();



//THIS CAN ALL BE DELETED IF YOU WANT, ITS JUST TESTING EACH QUERY BEING BUILT TO ENSURE CORRECTNESS


////SECTION 1 - Retrieving Stuff
      // easyQB.getUsersFromCompany();
      // easyQB.getAllCompanies();
      // easyQB.getAUsersPackages();
      // easyQB.getACompanysPackages();
      // easyQB.getACustomersPackages();

// client.connect()
// client.query(easyQB.getUsersFromCompany("Presidential Shark Industries"), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.getAllCompanies(), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.getAUsersPackages("lewi"), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.getACompanysPackages("Presidential Shark Industries"), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.getACustomersPackages("llapelle"), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })


////SECTION 2 - Updating Stuff
  // updateUsersAddress('llapelle', 'Bakersfield, TX')
  // updatePackageStartingLocation('1', 'Lukenbach Texas');
  // updatePackageEndingLocation('1', 'Jackson, TN');
  // updatePackageDeliveryStatus('1', 'IN TRANSIT');

// client.connect()
// client.query(easyQB.updateUsersAddress('llapelle', 'Bakersfield, TX'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.updatePackageStartingLocation('1', 'Lukenbach Texas'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.updatePackageEndingLocation('1', 'Jackson TN'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.updatePackageDeliveryStatus('1', 'IN TRANSIT'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })




////SECTION 3 - Inserting Stuff



// client.connect()
// client.query(easyQB.createACompany('Thingers', '1', 'logo.png', 'lorem ipsum etc', 'Deep River, MS'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.createAUser('Test', 'test', 't', 'lorem ipsum etc', 1,'address'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.createUserRelationToCompany(4,12), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

// client.connect()
// client.query(easyQB.createAPackage('testa', 'oof', 'wpw', '1/1/2020', 'alabama', 'in transit'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })


// client.connect()
// client.query(easyQB.createAPackageRelation('1','1'), (err, res) => {
//   console.log(res)
//   //Do whatever you want to with the data here...
//   client.end()
// })

////SECTION 4 - Deleting Stuff
//Not done yet, because we aren't using it for the demo. Writing the rest of the queries took a deceptively long time.

// // client.connect()
client.query(easyQB.getCompany('61'), (err, result) => {
  console.log(result.rows[0].companyname)})
//   //Do whatever you want to with the data here...
//   client.end()
// })



app.post('/fill-info', checkJwt, function(req, res) {
  if(req.body.role  == "user") {
  const setRow = async() =>{
    await client.query(easyQB.createAUser(req.body.fname, req.body.lname, req.body.username, req.body.address.streetAddress, req.body.phone, req.body.email, req.body.address.state, req.body.address.city, req.body.address.googleMapLink, req.body.zipCode), (err, result) => {
      if (err){         
        console.log(err.stack)
        res.status(400).json(err)
      } else {
        console.log(result.command)
        res.status(200).json(result.command)}
    })
  }
  setRow()
  }
  else if(req.body.role == "dadmin"){
    const setRow = async() => {
      await client.query(easyQB.createAUser(req.body.fname, req.body.lname, req.body.username, req.body.role, req.body.address.streetAddress, req.body.phone, req.body.email, req.body.address.state, req.body.address.city, req.body.address.googleMapLink, req.body.zipCode), (err, result) => {
        if (err){         
          console.log(err.stack)
          res.status(400).json(err)
        } else {
          console.log(result.command)
          const setAdmin = async() =>{
            await client.query(easyQB.createAnAdmin(req.body.username, req.body.admin.cname, req.body.admin.spkg, req.body.admin.mpkg, req.body.admin.lpkg, req.body.admin.elec, req.body.admin.deli, req.body.admin.heavy, req.body.admin.doc, req.body.admin.other, req.body.admin.express, req.body.admin.normal), (err, result1) => {
              if (err){         
                console.log(err.stack)
                res.status(400).json(err)
              } else {
                console.log(result1.command)
                res.status(200).json(result1.command)}
            })
          }
          setAdmin()
          }
      })
    }
    setRow()
  }
  else {
    const setRow = async() => {
      await client.query(easyQB.createAUser(req.body.fname, req.body.lname, req.body.username, req.body.role, req.body.address.streetAddress, req.body.phone, req.body.email, req.body.address.state, req.body.address.city, req.body.address.googleMapLink, req.body.zipCode), (err, result) => {
        if (err){         
          console.log(err.stack)
          res.status(400).json(err)
        } else {
          console.log(result.command)
          const setDriver = async() =>{
            await client.query(easyQB.createADriver(req.body.username, req.body.driver.cname, req.body.driver.lno), (err, result1) => {
              if (err){         
                console.log(err.stack)
                res.status(400).json(err)
              } else {
                console.log(result1.command)
                res.status(200).json(result1.command)}
            })
          }
          setDriver()
          }
      })
    }
    setRow()
  }
});

app.get('/api/me', checkJwt, function(req, res){
  const fetchRow = async() =>{
    const claims = get_jwt_claims(req)
    const email = claims['https://example.com/email']
    await client.query(easyQB.getUser(email), (err, result) => {
      if(result.rows.length > 0){
        res.status(200).json(result.rows)
      } else {
        res.status(400).json()
      }
    })
  }
  fetchRow()
});

app.post('/api/me', checkJwt, function(req, res){
  const fetchRow = async() =>{
    await client.query(easyQB.updateUser(req.body.email, req.body.fname, req.body.lname, req.body.phone, req.body.address.streetAddress, req.body.address.city, req.body.address.state, req.body.address.zip, req.body.address.googlelink), (err, result) => {
      if(err){
        res.status(400).json(err.stack)
      } else {
        res.status(200).json(result.rows)
      }
    })
  }
  fetchRow()
});

app.get('/api/employees', checkJwt, function(req, res){
  const fetchRow1 = async() =>{
    const claims = get_jwt_claims(req)
    const email = claims['https://example.com/email']
    await client.query(easyQB.getUserId(email), (err, result) => {
      console.log(result)
      if(err){
        res.status(400).json()
      } else {
        const uid = result.rows[0].userid;
        console.log(result.rows[0].userid);
          const fetchUsers = async() =>{
            await client.query(easyQB.getCompany(uid), (err, result1) => {
              if (err){         
                console.log(err.stack)
                res.status(400).json(err)
              } else {
                console.log(result1);
                const cname = result1.rows[0].companyname;
                const fetchEmployee = async() =>{
                  await client.query(easyQB.getEmployee(cname), (err, result2) => {
                    if (err){         
                      console.log(err.stack)
                      res.status(400).json(err)
                    } else {
                      console.log(result2.rows)
                      res.status(200).json(result2.rows)}
                  })
                }
                fetchEmployee()
              }
            })
          }
          fetchUsers()
      }
    })
  }
  fetchRow1()
});

app.post('/api/search', function(req, res) {
  const fetchRow = async() =>{
    console.log(req.body.queryValue)
    await client.query((req.body.queryValue), (err, result) => {
      if (err){
        console.log(err.stack)
        res.status(400).json(err)
      } else {
        console.log(result.rows)
        res.status(200).json(result.rows)}
    })
  }
  fetchRow()
});

app.listen(process.env.PORT || 5000);