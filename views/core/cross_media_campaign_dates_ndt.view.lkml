#########################################################{
# PURPOSE
# Finds the minimum and maximum report dates for a source_system and campaign
# and returns as dimensions. These dimensions are used in the calendar chart (i.e., timeline)
# found in LookML dashboard cross_media_2_campaigns.
#
# SOURCES
#   Explore cross_media_campaign_daily_agg
#
# REFERENCED BY
#   Explore cross_media_campaign_daily_agg
#
#########################################################}

view: cross_media_campaign_dates_ndt {
  derived_table: {
    sql:
      SELECT
        SourceSystem AS source_system,
        CampaignId AS campaign_id,
        MIN(ReportDate) AS min_report_date,
        MAX(ReportDate) AS max_report_date
      FROM ${cross_media_campaign_daily_agg.SQL_TABLE_NAME}
      GROUP BY 1, 2
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
    convert_tz: no
  }

  dimension: max_report_date {
    type: date
    description: "Latest report date of campaign"
    convert_tz: no
  }

  dimension: report_date_range {
    type: string
    description: "Display a campaign's reporting date range as \"[min report date] to [max report date]\""
    sql: CONCAT(${min_report_date},' to ',${max_report_date}) ;;
  }

  set: report_date_fields {
    fields: [min_report_date, max_report_date, report_date_range]
  }
}
