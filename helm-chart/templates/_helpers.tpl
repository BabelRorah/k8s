{{- define "fastapi-app.fullname" -}}
{{ include "fastapi-app.name" . }}-{{ .Release.Name }}
{{- end }}

{{- define "fastapi-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "fastapi-app.apiKey" -}}
{{ randAlphaNum 32 }}
{{- end }}
