output "i1name" {
        value = "${aws_instance.web.0.id}"
}

output "instance_last_id" {
        value = "${element(aws_instance.web.*.id, length(aws_instance.web.*.id)-1)}"
}

output "instances_list" {
        value = ["${aws_instance.web.*.id}"]
}
