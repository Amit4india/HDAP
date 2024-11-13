

resource "aws_s3_bucket" "product_in_box_state_k8s" {
  bucket = "k8spib-terraform-state-file"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

