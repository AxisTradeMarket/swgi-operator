{{- define "axis-swgi-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "axis-swgi-api.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "axis-swgi-api.name" . -}}
{{- end -}}
{{- end -}}

{{- define "axis-swgi-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "axis-swgi-api.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
