{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "chart.fullname" -}}
{{- .Values.main.application.name }}-deployment-{{ .Values.main.application.env }}
{{- end -}}

{{/*
Label helper will setup all the labels to apply to the object
*/}}
{{- define "csc.labels.common" -}}
cscglobal.com/owner.businessUnit: {{ .owner.businessUnit | quote}}
cscglobal.com/owner.teamName: {{ .owner.teamName | quote}}
cscglobal.com/compliance.moveStream: {{ .compliance.moveStream | quote}}
cscglobal.com/application.name: {{ .application.name | quote}}
cscglobal.com/application.tier: {{ .application.tier | quote}}
cscglobal.com/application.externalIngress: {{ .application.externalIngress | quote}}
cscglobal.com/runtime.appServer: {{ .runtime.appServer | quote}}
cscglobal.com/runtime.language: {{ .runtime.language | quote}}
{{- end -}}

{{- define "csc.labels.custom" -}}
{{- if .custom -}}
{{- range $key, $val := .custom -}}
{{ printf "cscglobal.com/custom.%s" $key }}: {{$val | quote }}
{{ end -}}
{{- end -}}
{{- end -}}

{{- define "csc.labels.helper" -}}
{{ include "csc.labels.common" .Values.labels }}
{{ include "csc.labels.custom" .Values.labels -}}
cscglobal.com/chart.name: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
cscglobal.com/application.environment: {{ .Values.main.application.env | quote}}
cscglobal.com/application.imageTag: "{{ .Values.collectors.artifactory.image.tag }}"
cscglobal.com/runtime.artifactoryImageName: "{{ .Values.collectors.artifactory.image.collectorname }}"
cscglobal.com/runtime.artifactoryImageTag: "{{ .Values.collectors.artifactory.image.tag }}"
{{- end -}}
