package controllers

import (
	"net/http"

	"github.com/aws/aws-sdk-go/service/s3"
)

func determineHTTPStatus(obj *s3.GetObjectOutput) int {
	if obj.ContentRange != nil && len(*obj.ContentRange) > 0 {
		return http.StatusPartialContent
	}
	return http.StatusOK
}
