'use strict';

/**
 * coffee service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::coffee.coffee');
