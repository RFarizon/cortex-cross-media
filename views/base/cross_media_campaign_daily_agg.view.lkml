#--> Hid dimensions named `total_` and restated as measures in the refinement view cross_media_campaign_daily_agg_rfn
#--> Moved auto-generated view for the product_hierarchy_texts array to separate file

view: cross_media_campaign_daily_agg {
  derived_table: {
    sql:
      WITH date_range AS (
        SELECT day AS ReportDate
        FROM UNNEST(GENERATE_DATE_ARRAY(DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY), CURRENT_DATE(), INTERVAL 1 DAY)) AS day
      ),
      campaigns AS (
        -- Google Ads
        SELECT 'GoogleAds' AS SourceSystem, 'Google Ads - Brand Search' AS CampaignName, 'CAMP-G01' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Electronics', 'Mobile Phones'] AS ProductHierarchyTexts, 2500 AS base_imp, 80 AS base_clicks, 55.0 AS base_cost, 365 AS start_offset, 0 AS end_offset
        UNION ALL
        SELECT 'GoogleAds' AS SourceSystem, 'Google Ads - Summer Sale' AS CampaignName, 'CAMP-G02' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Apparel', 'Shorts & Tees'] AS ProductHierarchyTexts, 3100 AS base_imp, 95 AS base_clicks, 62.0 AS base_cost, 150 AS start_offset, 30 AS end_offset
        UNION ALL
        SELECT 'GoogleAds' AS SourceSystem, 'Google Ads - Holiday Shopping Blitz' AS CampaignName, 'CAMP-G03' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Electronics', 'Audio'] AS ProductHierarchyTexts, 4200 AS base_imp, 140 AS base_clicks, 88.0 AS base_cost, 300 AS start_offset, 180 AS end_offset
        UNION ALL
        SELECT 'GoogleAds' AS SourceSystem, 'Google Ads - Spring Electronics' AS CampaignName, 'CAMP-G04' AS CampaignId, 'DE' AS CountryCode, 'Germany' AS CountryName, ARRAY['Electronics', 'Laptops'] AS ProductHierarchyTexts, 2800 AS base_imp, 85 AS base_clicks, 58.0 AS base_cost, 360 AS start_offset, 240 AS end_offset

        -- Meta
        UNION ALL
        SELECT 'Meta' AS SourceSystem, 'Meta - Retargeting & Lookalike' AS CampaignName, 'CAMP-M01' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Apparel', 'Backpacks'] AS ProductHierarchyTexts, 3200 AS base_imp, 110 AS base_clicks, 68.0 AS base_cost, 365 AS start_offset, 0 AS end_offset
        UNION ALL
        SELECT 'Meta' AS SourceSystem, 'Meta - Summer Fashion Collection' AS CampaignName, 'CAMP-M02' AS CampaignId, 'GB' AS CountryCode, 'United Kingdom' AS CountryName, ARRAY['Apparel', 'Dresses'] AS ProductHierarchyTexts, 2900 AS base_imp, 105 AS base_clicks, 64.0 AS base_cost, 120 AS start_offset, 20 AS end_offset
        UNION ALL
        SELECT 'Meta' AS SourceSystem, 'Meta - Black Friday Flash Sale' AS CampaignName, 'CAMP-M03' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Beauty', 'Skincare'] AS ProductHierarchyTexts, 4800 AS base_imp, 160 AS base_clicks, 95.0 AS base_cost, 280 AS start_offset, 200 AS end_offset
        UNION ALL
        SELECT 'Meta' AS SourceSystem, 'Meta - Influencer Showcase' AS CampaignName, 'CAMP-M04' AS CampaignId, 'CA' AS CountryCode, 'Canada' AS CountryName, ARRAY['Home & Kitchen', 'Appliances'] AS ProductHierarchyTexts, 2600 AS base_imp, 90 AS base_clicks, 52.0 AS base_cost, 210 AS start_offset, 90 AS end_offset

        -- TikTok
        UNION ALL
        SELECT 'TikTok' AS SourceSystem, 'TikTok - Viral Product Launch' AS CampaignName, 'CAMP-T01' AS CampaignId, 'GB' AS CountryCode, 'United Kingdom' AS CountryName, ARRAY['Beauty', 'Skincare'] AS ProductHierarchyTexts, 5500 AS base_imp, 180 AS base_clicks, 85.0 AS base_cost, 365 AS start_offset, 0 AS end_offset
        UNION ALL
        SELECT 'TikTok' AS SourceSystem, 'TikTok - Back to School Hashtag' AS CampaignName, 'CAMP-T02' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Apparel', 'Backpacks'] AS ProductHierarchyTexts, 4900 AS base_imp, 165 AS base_clicks, 78.0 AS base_cost, 90 AS start_offset, 10 AS end_offset
        UNION ALL
        SELECT 'TikTok' AS SourceSystem, 'TikTok - Spring Skincare Challenge' AS CampaignName, 'CAMP-T03' AS CampaignId, 'DE' AS CountryCode, 'Germany' AS CountryName, ARRAY['Beauty', 'Cosmetics'] AS ProductHierarchyTexts, 4100 AS base_imp, 140 AS base_clicks, 70.0 AS base_cost, 330 AS start_offset, 180 AS end_offset
        UNION ALL
        SELECT 'TikTok' AS SourceSystem, 'TikTok - Holiday Unboxing Fest' AS CampaignName, 'CAMP-T04' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Electronics', 'Gadgets'] AS ProductHierarchyTexts, 5800 AS base_imp, 195 AS base_clicks, 92.0 AS base_cost, 260 AS start_offset, 170 AS end_offset

        -- DV360
        UNION ALL
        SELECT 'DV360' AS SourceSystem, 'DV360 - Video Branding Q3' AS CampaignName, 'CAMP-D01' AS CampaignId, 'CA' AS CountryCode, 'Canada' AS CountryName, ARRAY['Electronics', 'Audio'] AS ProductHierarchyTexts, 4100 AS base_imp, 95 AS base_clicks, 72.0 AS base_cost, 365 AS start_offset, 0 AS end_offset
        UNION ALL
        SELECT 'DV360' AS SourceSystem, 'DV360 - Connected TV Premium' AS CampaignName, 'CAMP-D02' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Electronics', 'TV & Video'] AS ProductHierarchyTexts, 6200 AS base_imp, 120 AS base_clicks, 110.0 AS base_cost, 180 AS start_offset, 40 AS end_offset
        UNION ALL
        SELECT 'DV360' AS SourceSystem, 'DV360 - Programmatic Audio Wave' AS CampaignName, 'CAMP-D03' AS CampaignId, 'GB' AS CountryCode, 'United Kingdom' AS CountryName, ARRAY['Media', 'Music'] AS ProductHierarchyTexts, 3500 AS base_imp, 80 AS base_clicks, 55.0 AS base_cost, 350 AS start_offset, 150 AS end_offset
        UNION ALL
        SELECT 'DV360' AS SourceSystem, 'DV360 - Winter Holiday Awareness' AS CampaignName, 'CAMP-D04' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Home & Kitchen', 'Decor'] AS ProductHierarchyTexts, 4400 AS base_imp, 100 AS base_clicks, 76.0 AS base_cost, 270 AS start_offset, 160 AS end_offset
      )
      SELECT
        c.CampaignId,
        c.CampaignName,
        c.CountryCode,
        c.CountryName,
        TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL CAST(ABS(MOD(FARM_FINGERPRINT(CAST(d.ReportDate AS STRING)), 30)) AS INT64) DAY) AS LastUpdateTS,
        'P1' AS ProductHierarchyId,
        c.ProductHierarchyTexts,
        'Category' AS ProductHierarchyType,
        d.ReportDate,
        'USD' AS SourceCurrency,
        c.SourceSystem,
        'USD' AS TargetCurrency,
        CAST(ROUND(c.base_clicks + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), c.CampaignId, 'clicks')), 40))) AS INT64) AS TotalClicks,
        ROUND(c.base_cost + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), c.CampaignId, 'cost')), 30)), 2) AS TotalCostInSourceCurrency,
        ROUND(c.base_cost + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), c.CampaignId, 'cost')), 30)), 2) AS TotalCostInTargetCurrency,
        CAST(ROUND(c.base_imp + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), c.CampaignId, 'imp')), 1500))) AS INT64) AS TotalImpressions
      FROM date_range d
      JOIN campaigns c
        ON d.ReportDate >= DATE_SUB(CURRENT_DATE(), INTERVAL c.start_offset DAY)
       AND d.ReportDate <= DATE_SUB(CURRENT_DATE(), INTERVAL c.end_offset DAY)
    ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.CampaignId ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.CampaignName ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.CountryCode ;;
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.CountryName ;;
  }
  dimension_group: last_update_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LastUpdateTS ;;
  }
  dimension: product_hierarchy_id {
    type: string
    sql: ${TABLE}.ProductHierarchyId ;;
  }
  dimension: product_hierarchy_texts {
    hidden: yes
    sql: ${TABLE}.ProductHierarchyTexts ;;
  }
  dimension: product_hierarchy_type {
    type: string
    sql: ${TABLE}.ProductHierarchyType ;;
  }
  dimension_group: report {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ReportDate ;;
  }
  dimension: source_currency {
    type: string
    sql: ${TABLE}.SourceCurrency ;;
  }
  dimension: source_system {
    type: string
    sql: ${TABLE}.SourceSystem ;;
  }
  dimension: target_currency {
    type: string
    sql: ${TABLE}.TargetCurrency ;;
  }
  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
}
