const usersCollection = require('./usersCollection')

async function getRandomUser() {
  return await usersCollection.aggregate([{$sample: {size: 5}}])
}

module.exports = getRandomUser