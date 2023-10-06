resource "aws_ecr_repository" "krolm_repository" {
  name = "krolm-repo"
}

output "krolm_repository_uri" {
  value = aws_ecr_repository.krolm_repository.repository_url
}
