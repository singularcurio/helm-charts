{{/*
Expand the name of the chart.
*/}}
{{- define "opnsense-mcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "opnsense-mcp.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart label.
*/}}
{{- define "opnsense-mcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "opnsense-mcp.labels" -}}
helm.sh/chart: {{ include "opnsense-mcp.chart" . }}
{{ include "opnsense-mcp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "opnsense-mcp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opnsense-mcp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name.
*/}}
{{- define "opnsense-mcp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opnsense-mcp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Name of the Secret holding OPNsense credentials.
*/}}
{{- define "opnsense-mcp.secretName" -}}
{{- if .Values.opnsense.existingSecret }}
{{- .Values.opnsense.existingSecret }}
{{- else }}
{{- include "opnsense-mcp.fullname" . }}
{{- end }}
{{- end }}
