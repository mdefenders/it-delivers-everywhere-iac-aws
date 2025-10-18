module "k8s_apps" {
  source = "../../modules/k8s-apps"
  argocd_chart_version  = var.argocd_chart_version
  appsets_chart_version = var.appsets_chart_version
  deploy_appsets        = var.deploy_appsets
  appset_name           = var.appset_name
  github_org            = var.github_org
  app_chart_repo        = var.app_chart_repo
  app_chart_name        = var.app_chart_name
  app_chart_version     = var.app_chart_version
}
