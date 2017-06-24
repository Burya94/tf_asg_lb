
resource "aws_iam_group" "testgroup"{
  name = "s3_dev"
}
resource "aws_iam_user" "testuser21" {
  name = "testuser21"
}
resource "aws_iam_group_membership" "team" {
  name = "team"

  users = ["${aws_iam_user.testuser21.name}"]
  group = "${aws_iam_group.testgroup.name}"
}
data "aws_iam_policy_document" "grouppol"{
  statement {
    actions = [
    "s3:ListAllMyBuckets",
    "s3:GetBucketLocation"
    ]
    resources = [ "arn:aws:s3:::*"]

}
}
resource "aws_iam_group_policy" "gpol"{
  name = "gpoll_for_dev"
  group = "${aws_iam_group.testgroup.id}"
  policy = "${data.aws_iam_policy_document.grouppol.json}"
}
