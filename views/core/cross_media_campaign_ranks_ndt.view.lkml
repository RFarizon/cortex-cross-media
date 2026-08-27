#########################################################{
# PURPOSE
# Ranks campaigns for a source system by min report date and campaign.
# Used to filter the number of campaigns displayed per media platform
# in the cross_media_2_campaigns dashboard
#
# SOURCES
#   Explore cross_media_campaign_daily_agg
#
# REFERENCED BY
#   Explore cross_media_campaign_daily_agg
#
#########################################################}

view: cross_media_campaign_ranks_ndt {
  derived_table: {
    sql:
      WITH base AS (
        SELECT
          SourceSystem AS source_system,
          CampaignId AS campaign_id,
          MIN(ReportDate) AS min_report_date,
          MAX(ReportDate) AS max_report_date
        FROM ${cross_media_campaign_daily_agg.SQL_TABLE_NAME}
        GROUP BY 1, 2
      )
      SELECT
        source_system,
        campaign_id,
        min_report_date,
        max_report_date,
        RANK() OVER (PARTITION BY source_system ORDER BY min_report_date, campaign_id) AS rank_by_date
      FROM base
    ;;
  }

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${source_system},${campaign_id}) ;;
  }

  dimension: source_system {
    type: string
    label: "Media Platform"
    description: "Source system. Either GoogleAds, Meta, TikTok or YouTube (DV360)"
  }

  dimension: campaign_id {
    type: string
    description: "ID of campaign from media platform"
  }

  dimension: min_report_date {
    type: date
    description: "Earliest report date of campaign"
  }

  dimension: max_report_date {
    type: date
    description: "Latest report date of campaign"
  }

  dimension: rank_by_date {
    type: number
    label: "Campaign Rank by Date"
    description: "Rank of campaign for a media platform sorted by minimum report date and campaign id"
    sql: ${TABLE}.rank_by_date ;;
  }

  dimension: is_within_campaign_limit {
    type: yesno
    description: "Yes if campaign ranking by minimum report date is less than or equal to the parameter Campaign Limit per Media Platform"
    sql: ${rank_by_date} <= ${cross_media_campaign_daily_agg.selected_campaign_limit} ;;
  }

  set: report_date_fields {
    fields: [rank_by_date, is_within_campaign_limit]
  }
}
