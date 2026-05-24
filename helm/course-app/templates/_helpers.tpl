{{/* Short chart name, used in labels */}}
{{- define "course-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{/* Full resource name: {release}-{chart}, avoids conflicts across releases */}}
{{- define "course-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Standard k8s recommended labels for every resource */}}
{{- define "course-app.labels" -}}
app.kubernetes.io/name: {{ include "course-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}

{{/* Selector labels (immutable, so no version) */}}
{{- define "course-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "course-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Redis service from bitnami subchart: {release}-redis-master */}}
{{- define "course-app.redisHost" -}}
{{- printf "%s-redis-master" .Release.Name -}}
{{- end -}}

{{/* Full Redis URL exposed to the app via ConfigMap */}}
{{- define "course-app.redisUrl" -}}
{{- printf "redis://%s:6379" (include "course-app.redisHost" .) -}}
{{- end -}}
