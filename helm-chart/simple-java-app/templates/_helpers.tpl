{{- define "simple-java-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "simple-java-app.labels" -}}
app.kubernetes.io/name: {{ include "simple-java-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "simple-java-app.selectorLabels" -}}
app: {{ include "simple-java-app.name" . }}
{{- end -}}
