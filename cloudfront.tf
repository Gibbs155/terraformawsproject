resource "aws_cloudfront_distribution" "api_gateway_cf" {
  origin {
    domain_name = "${aws_api_gateway_rest_api.rest_api.id}.execute-api.${var.myregion}.amazonaws.com"
    origin_path = "/${var.path_part}/${var.stage_name}"
    origin_id   = "api"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1"]
    }
  }
  enabled = true
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "api"

    forwarded_values {
      query_string = true
      headers      = ["Accept", "Referer", "Authorization", "Content-Type"]
      cookies {
        forward = "all"
      }
    }
    viewer_protocol_policy = "https-only"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }

  }
  retain_on_delete = true # lo destruirá en lugar de deshabilitarlo si queremos deshabilitarlo, entonces no es necesario especificarlo explícitamente
  depends_on       = [aws_api_gateway_integration.rest_api_integration, aws_api_gateway_rest_api.rest_api]

  #   provisioner "local-exec" {
  #     command = "./graph.sh"    
  #   }
}