{{/*
Expand the name of the chart.
*/}}
{{- define "opnsense-ingress-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "opnsense-ingress-operator.fullname" -}}
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
{{- define "opnsense-ingress-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "opnsense-ingress-operator.labels" -}}
helm.sh/chart: {{ include "opnsense-ingress-operator.chart" . }}
{{ include "opnsense-ingress-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "opnsense-ingress-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opnsense-ingress-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name.
*/}}
{{- define "opnsense-ingress-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opnsense-ingress-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Name of the Secret holding OPNsense credentials.
*/}}
{{- define "opnsense-ingress-operator.secretName" -}}
{{- if .Values.opnsense.existingSecret }}
{{- .Values.opnsense.existingSecret }}
{{- else }}
{{- include "opnsense-ingress-operator.fullname" . }}
{{- end }}
{{- end }}
