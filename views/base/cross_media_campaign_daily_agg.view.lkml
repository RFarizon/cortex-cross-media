#--> Hid dimensions named `total_` and restated as measures in the refinement view cross_media_campaign_daily_agg_rfn
#--> Moved auto-generated view for the product_hierarchy_texts array to separate file

view: cross_media_campaign_daily_agg {
  derived_table: {
    sql:
      WITH date_range AS (
        SELECT day AS ReportDate
        FROM UNNEST(GENERATE_DATE_ARRAY(DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY), CURRENT_DATE(), INTERVAL 1 DAY)) AS day
      ),
      platforms AS (
        SELECT 'GoogleAds' AS SourceSystem, 'Google Ads - Search & Display' AS CampaignName, 'CAMP-G01' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Electronics', 'Mobile Phones'] AS ProductHierarchyTexts, 2500 AS base_imp, 80 AS base_clicks, 55.0 AS base_cost
        UNION ALL
        SELECT 'Meta' AS SourceSystem, 'Meta - Retargeting & Lookalike' AS CampaignName, 'CAMP-M02' AS CampaignId, 'US' AS CountryCode, 'United States' AS CountryName, ARRAY['Apparel', 'Backpacks'] AS ProductHierarchyTexts, 3200 AS base_imp, 110 AS base_clicks, 68.0 AS base_cost
        UNION ALL
        SELECT 'TikTok' AS SourceSystem, 'TikTok - Viral Product Launch' AS CampaignName, 'CAMP-T03' AS CampaignId, 'GB' AS CountryCode, 'United Kingdom' AS CountryName, ARRAY['Beauty', 'Skincare'] AS ProductHierarchyTexts, 5500 AS base_imp, 180 AS base_clicks, 85.0 AS base_cost
        UNION ALL
        SELECT 'DV360' AS SourceSystem, 'DV360 - Video Branding Campaign' AS CampaignName, 'CAMP-D04' AS CampaignId, 'CA' AS CountryCode, 'Canada' AS CountryName, ARRAY['Electronics', 'Audio'] AS ProductHierarchyTexts, 4100 AS base_imp, 95 AS base_clicks, 72.0 AS base_cost
      )
      SELECT
        p.CampaignId,
        p.CampaignName,
        p.CountryCode,
        p.CountryName,
        TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL CAST(ABS(MOD(FARM_FINGERPRINT(CAST(d.ReportDate AS STRING)), 30)) AS INT64) DAY) AS LastUpdateTS,
        'P1' AS ProductHierarchyId,
        p.ProductHierarchyTexts,
        'Category' AS ProductHierarchyType,
        d.ReportDate,
        'USD' AS SourceCurrency,
        p.SourceSystem,
        'USD' AS TargetCurrency,
        CAST(ROUND(p.base_clicks + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), p.SourceSystem, 'clicks')), 40))) AS INT64) AS TotalClicks,
        ROUND(p.base_cost + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), p.SourceSystem, 'cost')), 30)), 2) AS TotalCostInSourceCurrency,
        ROUND(p.base_cost + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), p.SourceSystem, 'cost')), 30)), 2) AS TotalCostInTargetCurrency,
        CAST(ROUND(p.base_imp + ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(d.ReportDate AS STRING), p.SourceSystem, 'imp')), 1500))) AS INT64) AS TotalImpressions
      FROM date_range d
      CROSS JOIN platforms p
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
