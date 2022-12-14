'use strict';

const AWS = require('aws-sdk')
const bcrypt = require('bcryptjs')
const { v4: uuid } = require('uuid')

AWS.config.update({
  region: process.env.AWS_REGION
})

const documentClient = new AWS.DynamoDB.DocumentClient()

module.exports.register = async (event) => {
  const body = JSON.parse(event.body)

  await documentClient.put({
    TableName: process.env.DYNAMODB_USERS,
    Item: {
      id: uuid(),
      name: body.name,
      email: body.email,
      password: bcrypt.hashSync(body.password, 10)
    }
  }).promise()

  return {
    statusCode: 201,
    body: JSON.stringify({ message: 'User created successfully' })
  }
};
