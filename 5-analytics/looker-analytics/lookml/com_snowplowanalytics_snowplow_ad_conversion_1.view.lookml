# Copyright (c) 2013-2014 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
#
# Author(s): Yali Sassoon
# Copyright: Copyright (c) 2013-2014 Snowplow Analytics Ltd
# License: Apache License Version 2.0
#
# Compatibility: iglu:com.snowplowanalytics.snowplow/ad_conversion/jsonschema/1-0-0

- view: ad_conversions
  sql_table_name: atomic.com_snowplowanalytics_snowplow_ad_conversion_1
  fields:

# DIMENSIONS #

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.root_id

  - dimension: timestamp
    sql: ${TABLE}.root_tstamp

  - dimension_group: timestamp
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: conversion_id
    sql: ${TABLE}.click_id

  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: advertiser_id
    sql: ${TABLE}.advertiser_id

  - dimension: category
    sql: ${TABLE}.category

  - dimension: action
    sql: ${TABLE}.action

  - dimension: property
    sql: ${TABLE}.property

  - dimension: cost_model
    sql: ${TABLE}.cost_model

  - dimension: cost
    type: number
    decimals: 2
    sql: ${TABLE}.cost

  - dimension: initial_value
    type: number
    decimals: 2
    sql: ${TABLE}.initial_value

# MEASURES #

  - measure: count
    type: count_distinct
    sql: ${event_id}

  - measure: cpa_cost
    type: sum
    sql: ${cost}
    filters:
      cost_model: "cpa"

  - measure: cpm_cost
    type: number
    decimals: 2
    sql: SUM(${cost})/1000
    filters:
      cost_model: 'cpm'

  - measure: value_driven_initial_estimate
    type: sum
    sql: ${initial_value}
