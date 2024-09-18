enum Panel { upper, lower }

typedef PanelLocation = (int, Panel, int?);

extension CopyablePanelLocation on PanelLocation {
  PanelLocation copyWith({int? index, Panel? panel, int? panelIndex}) =>
      (index ?? this.$1, panel ?? this.$2, panelIndex ?? this.$3);
}
