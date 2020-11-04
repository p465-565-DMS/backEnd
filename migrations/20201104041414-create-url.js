'use strict';

const { defaultValueSchemable } = require("sequelize/types/lib/utils");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('users', {
      userid: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      fname: {
        allowNull: false,
        type: Sequelize.STRING
      },
      lname: {
        allowNull: false,
        type: Sequelize.STRING
      },
      username: {
        unique: true,
        allowNull: false,
        type: Sequelize.STRING
      },
      role: {
        allowNull: false,
        type: Sequelize.STRING
      },
      address: {
        allowNull: false,
        type: Sequelize.STRING
      },
      phone: {
        type: Sequelize.STRING
      },
      email: {
        type: Sequelize.STRING
      },
      state: {
        type: Sequelize.STRING
      },
      city: {
        type: Sequelize.STRING
      },
      zipcode: {
        type: Sequelize.STRING
      },
      googlelink: {
        type: Sequelize.STRING
      }
    });
    await queryInterface.createTable('deliveryadmin', {
      adminid: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      userid: {
        allowNull: false,
        foreign: true,
        type: Sequelize.INTEGER,
        foreignKey: {
          name: 'deliveryadmin_userid_fk',
          table: 'users',
          rules: {
            onDelete: 'CASCADE',
            onUpdate: 'RESTRICT'
          },
          mapping: {
            userid: 'adminid'
          }
        }
      },
      compname: {
        allowNull: false,
        type: Sequelize.STRING
      }
    });
    await queryInterface.createTable('deliverydriver', {
      driverid: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      userid: {
        allowNull: false,
        foreign: true,
        type: Sequelize.INTEGER,
        foreignKey: {
          name: 'deliverydriver_userid_fk',
          table: 'users',
          rules: {
            onDelete: 'CASCADE',
            onUpdate: 'RESTRICT'
          },
          mapping: {
            userid: 'driverid'
          }
        }
      },
      compname: {
        allowNull: false,
        type: Sequelize.STRING
      },
      licenseno: {
        type: Sequelize.STRING
      }
    });
    await queryInterface.createTable('servicedetails', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      adminid: {
        allowNull: false,
        foreign: true,
        type: Sequelize.INTEGER,
        foreignKey: {
          name: 'servicedetails_adminid_fk',
          table: 'deliveryadmin',
          rules: {
            onDelete: 'CASCADE',
            onUpdate: 'RESTRICT'
          },
          mapping: {
            adminid: 'id'
          }
        }
      },
      pspeed: {
        type: Sequelize.STRING
      },
      pweight: {
        type: Sequelize.STRING
      },
      ptype: {
        allowNull: false,
        type: Sequelize.STRING
      },
      psize: {
        type: Sequelize.STRING
      },
      price: {
        allowNull: true,
        type: Sequelize.NUMERIC
      }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('users');
    await queryInterface.dropTable('deliveryadmin');
    await queryInterface.dropTable('deliverydriver');
    await queryInterface.dropTable('servicedetails');
  }
};