resource "null_resource" "main" {
  # インスタンスの ID が変わった ( インスタンスが作り直された ) ときにコマンドを実行する例
  triggers = {
    instance_id = aws_instance.main.id
  }

  provisioner "local-exec" {
    # 実行するコマンド
    command = "echo null resource"
  }
}

resource "terraform_data" "like_null_resource" {
  # インスタンスの ID が変わった ( インスタンスが作り直された ) ときにコマンドを実行する例
  triggers_replace = [
    aws_instance.main.id
  ]

  # 実行するコマンド
  provisioner "local-exec" {
    command = "echo terraform data"
  }
}
