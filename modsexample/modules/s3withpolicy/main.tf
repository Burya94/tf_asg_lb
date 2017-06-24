provider "aws" {
    region = "${var.els_srch_vi_region}"
    access_key = "${var.els_srch_vi_aws_access_key}"
    secret_key = "${var.els_srch_vi_aws_secret_key}"
}

resource "aws_s3_bucket" "s3_tfstate_bucket" {
    bucket = "${var.s3_tfstate_bucket_name}"
    acl = "private"
    versioning {
        enabled = true
    }
}

data "aws_iam_policy_document" "policy"{
  statement {
    actions = [
      "s3:*",
    ]
  resources = [
    "arn:aws:s3:::${var.s3_tfstate_bucket_name}"
  ]
  principals {
      type        = "AWS"
      identifiers = ["${var.iam_group_id}"]
    }
  }
}

resource "aws_s3_bucket_policy" "s"{
  depends_on = ["aws_s3_bucket.s3_tfstate_bucket"]
  bucket = "${aws_s3_bucket.s3_tfstate_bucket.id}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}
