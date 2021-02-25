###########################
#####   Resources    ######
###########################

resource "kubernetes_daemonset" "snort" {
  count = var.deploy_snort  == "true" ? 1 : 0
  depends_on  = [null_resource.wait_nodes_join_cluster, module.eks-cluster]
  metadata {
    name = "snort-privileged"
    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        k8s-app = "privileged-container"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "privileged-container"
        }
      }

      spec {
        container {
          image = "${var.ecr_endpoint}/${var.snort_image}:${var.snort_image_tag}"
          name = "snort"

          resources {
            limits {
              cpu = var.limits_cpu_snort
              memory = var.limits_memory_snort
            }
            requests {
              cpu = var.requests_cpu_snort
              memory = var.requests_memory_snort
            }
          }
          stdin = true
          security_context {
            privileged = true
          }
        }
        host_network = true
        host_pid = true
        restart_policy = "Always"
      }
    }
  }
}