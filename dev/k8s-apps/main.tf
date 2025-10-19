module "k8s_apps" {
  source                   = "../../modules/k8s-apps"
  argocd_chart_version     = var.argocd_chart_version
  appsets_chart_version    = var.appsets_chart_version
  deploy_appsets           = var.deploy_appsets
  appset_name              = var.appset_name
  github_org               = var.github_org
  app_chart_repo           = var.app_chart_repo
  app_chart_name           = var.app_chart_name
  app_chart_version        = var.app_chart_version
  autoscaler_chart_version = var.autoscaler_chart_version
  eks_cluster_name         = data.terraform_remote_state.k8s.outputs.cluster_name
  autoscaler_role_arn      = data.terraform_remote_state.k8s.outputs.cluster_autoscaler_irsa_role
}
