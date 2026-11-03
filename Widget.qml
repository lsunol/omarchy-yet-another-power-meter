import QtQuick
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "yet-another-power-meter"

  property string label: "-- W"

  // Reserve room for the widest label so the bar never reflows neighbours.
  readonly property real slotMargin: Style.spaceReal(10)
  implicitWidth: Math.ceil(metrics.advanceWidth) + slotMargin * 2
  implicitHeight: button.implicitHeight
  width: implicitWidth
  height: implicitHeight

  TextMetrics {
    id: metrics
    font.family: root.bar ? root.bar.fontFamily : Style.font.family
    font.pixelSize: Style.font.body
    text: "+00.0 W"
  }

  Process {
    id: probe
    command: ["sh", "-c", "f=/sys/class/power_supply/BAT0; s=$(cat $f/status); p=$(cat $f/power_now); awk -v p=$p -v s=$s 'BEGIN{printf \"%s%.1f W\", (s==\"Charging\"?\"+\":\"\"), p/1000000}'"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.label = String(text).trim()
    }
  }

  Timer {
    interval: 3000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: if (!probe.running) probe.running = true
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    fontSize: Style.font.body
    fixedWidth: root.implicitWidth
    tooltipText: "Instantaneous battery power draw"
  }
}
