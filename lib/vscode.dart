@JS()
library vscode;

import "package:js/js.dart";

/// ---------------------------------------------------------------------------------------------
/// Copyright (c) Microsoft Corporation. All rights reserved.
/// Licensed under the MIT License. See License.txt in the project root for license information.
/// --------------------------------------------------------------------------------------------

// Module vscode
/// The version of the editor.
@JS("vscode.version")
external String get version;

/// Represents a reference to a command. Provides a title which
/// will be used to represent a command in the UI and, optionally,
/// an array of arguments which will be passed to the command handler
/// function when invoked.
@anonymous
@JS()
abstract class Command {
  /// Title of the command, like `save`.
  external String get title;
  external set title(String v);

  /// The identifier of the actual command handler.
  /// @see [commands.registerCommand](#commands.registerCommand).
  external String get command;
  external set command(String v);

  /// Arguments that the command handler should be
  /// invoked with.
  external List<dynamic> get arguments;
  external set arguments(List<dynamic> v);
  external factory Command(
      {String title, String command, List<dynamic> arguments});
}

/// Represents a line of text, such as a line of source code.
/// TextLine objects are __immutable__. When a [document](#TextDocument) changes,
/// previously retrieved lines will not represent the latest state.
@anonymous
@JS()
abstract class TextLine {
  /// The zero-based line number.
  /// @readonly
  external num get lineNumber;
  external set lineNumber(num v);

  /// The text of this line without the line separator characters.
  /// @readonly
  external String get text;
  external set text(String v);

  /// The range this line covers without the line separator characters.
  /// @readonly
  external Range get range;
  external set range(Range v);

  /// The range this line covers with the line separator characters.
  /// @readonly
  external Range get rangeIncludingLineBreak;
  external set rangeIncludingLineBreak(Range v);

  /// The offset of the first character which is not a whitespace character as defined
  /// by `/\s/`. **Note** that if a line is all whitespaces the length of the line is returned.
  /// @readonly
  external num get firstNonWhitespaceCharacterIndex;
  external set firstNonWhitespaceCharacterIndex(num v);

  /// Whether this line is whitespace only, shorthand
  /// for [TextLine.firstNonWhitespaceCharacterIndex](#TextLine.firstNonWhitespaceCharacterIndex) === [TextLine.text.length](#TextLine.text).
  /// @readonly
  external bool get isEmptyOrWhitespace;
  external set isEmptyOrWhitespace(bool v);
  external factory TextLine(
      {num lineNumber,
      String text,
      Range range,
      Range rangeIncludingLineBreak,
      num firstNonWhitespaceCharacterIndex,
      bool isEmptyOrWhitespace});
}

/// Represents a text document, such as a source file. Text documents have
/// [lines](#TextLine) and knowledge about an underlying resource like a file.
@anonymous
@JS()
abstract class TextDocument {
  /// The associated URI for this document. Most documents have the __file__-scheme, indicating that they
  /// represent files on disk. However, some documents may have other schemes indicating that they are not
  /// available on disk.
  /// @readonly
  external Uri get uri;
  external set uri(Uri v);

  /// The file system path of the associated resource. Shorthand
  /// notation for [TextDocument.uri.fsPath](#TextDocument.uri). Independent of the uri scheme.
  /// @readonly
  external String get fileName;
  external set fileName(String v);

  /// Is this document representing an untitled file.
  /// @readonly
  external bool get isUntitled;
  external set isUntitled(bool v);

  /// The identifier of the language associated with this document.
  /// @readonly
  external String get languageId;
  external set languageId(String v);

  /// The version number of this document (it will strictly increase after each
  /// change, including undo/redo).
  /// @readonly
  external num get version;
  external set version(num v);

  /// true if there are unpersisted changes.
  /// @readonly
  external bool get isDirty;
  external set isDirty(bool v);

  /// Save the underlying file.
  /// has been saved. If the file was not dirty or the save failed,
  /// will return false.
  external Thenable<bool> save();

  /// The number of lines in this document.
  /// @readonly
  external num get lineCount;
  external set lineCount(num v);

  /// Returns a text line denoted by the line number. Note
  /// that the returned object is *not* live and changes to the
  /// document are not reflected.
  /*external TextLine lineAt(num line);*/
  /// Returns a text line denoted by the position. Note
  /// that the returned object is *not* live and changes to the
  /// document are not reflected.
  /// The position will be [adjusted](#TextDocument.validatePosition).
  /// @see [TextDocument.lineAt](#TextDocument.lineAt)
  /*external TextLine lineAt(Position position);*/
  external TextLine lineAt(dynamic /*num|Position*/ line_position);

  /// Converts the position to a zero-based offset.
  /// The position will be [adjusted](#TextDocument.validatePosition).
  external num offsetAt(Position position);

  /// Converts a zero-based offset to a position.
  external Position positionAt(num offset);

  /// Get the text of this document. A substring can be retrieved by providing
  /// a range. The range will be [adjusted](#TextDocument.validateRange).
  external String getText([Range range]);

  /// Get a word-range at the given position. By default words are defined by
  /// common separators, like space, -, _, etc. In addition, per languge custom
  /// [word definitions](#LanguageConfiguration.wordPattern) can be defined. It
  /// is also possible to provide a custom regular expression.
  /// The position will be [adjusted](#TextDocument.validatePosition).
  external dynamic /*Range|dynamic*/ getWordRangeAtPosition(Position position,
      [RegExp regex]);

  /// Ensure a range is completely contained in this document.
  external Range validateRange(Range range);

  /// Ensure a position is contained in the range of this document.
  external Position validatePosition(Position position);
}

/// Represents a line and character position, such as
/// the position of the cursor.
/// Position objects are __immutable__. Use the [with](#Position.with) or
/// [translate](#Position.translate) methods to derive new positions
/// from an existing position.
@JS("vscode.Position")
class Position {
  // @Ignore
  Position.fakeConstructor$();

  /// The zero-based line value.
  /// @readonly
  external num get line;
  external set line(num v);

  /// The zero-based character value.
  /// @readonly
  external num get character;
  external set character(num v);
  external factory Position(num line, num character);

  /// Check if `other` is before this position.
  /// or on the same line on a smaller character.
  external bool isBefore(Position other);

  /// Check if `other` is before or equal to this position.
  /// or on the same line on a smaller or equal character.
  external bool isBeforeOrEqual(Position other);

  /// Check if `other` is after this position.
  /// or on the same line on a greater character.
  external bool isAfter(Position other);

  /// Check if `other` is after or equal to this position.
  /// or on the same line on a greater or equal character.
  external bool isAfterOrEqual(Position other);

  /// Check if `other` equals this position.
  /// the line and character of this position.
  external bool isEqual(Position other);

  /// Compare this to `other`.
  /// a number greater than zero if this position is after the given position, or zero when
  /// this and the given position are equal.
  external num compareTo(Position other);

  /// Create a new position relative to this position.
  /// character and the corresponding deltas.
  /*external Position translate([num lineDelta, num characterDelta]);*/
  /// Derived a new position relative to this position.
  /// is not changing anything.
  /*external Position translate({ lineDelta?: number; characterDelta?: number; } change);*/
  external Position translate(
      [dynamic /*num|{ lineDelta?: number; characterDelta?: number; }*/ lineDelta_change,
      num characterDelta]);

  /// Create a new position derived from this position.
  /*external Position JS$with([num line, num character]);*/
  /// Derived a new position from this position.
  /// is not changing anything.
  /*external Position JS$with({ line?: number; character?: number; } change);*/
  external Position JS$with(
      [dynamic /*num|{ line?: number; character?: number; }*/ line_change,
      num character]);
}

/// A range represents an ordered pair of two positions.
/// It is guaranteed that [start](#Range.start).isBeforeOrEqual([end](#Range.end))
/// Range objects are __immutable__. Use the [with](#Range.with),
/// [intersection](#Range.intersection), or [union](#Range.union) methods
/// to derive new ranges from an existing range.
@JS("vscode.Range")
class Range {
  // @Ignore
  Range.fakeConstructor$();

  /// The start position. It is before or equal to [end](#Range.end).
  /// @readonly
  external Position get start;
  external set start(Position v);

  /// The end position. It is after or equal to [start](#Range.start).
  /// @readonly
  external Position get end;
  external set end(Position v);

  /// Create a new range from two positions. If `start` is not
  /// before or equal to `end`, the values will be swapped.
  /*external factory Range(Position start, Position end);*/
  /// Create a new range from number coordinates. It is a shorter equivalent of
  /// using `new Range(new Position(startLine, startCharacter), new Position(endLine, endCharacter))`
  /*external factory Range(num startLine, num startCharacter, num endLine, num endCharacter);*/
  external factory Range(dynamic /*Position|num*/ start_startLine,
      dynamic /*Position|num*/ end_startCharacter,
      [num endLine, num endCharacter]);

  /// `true` iff `start` and `end` are equal.
  external bool get isEmpty;
  external set isEmpty(bool v);

  /// `true` iff `start.line` and `end.line` are equal.
  external bool get isSingleLine;
  external set isSingleLine(bool v);

  /// Check if a position or a range is contained in this range.
  /// to this range.
  external bool contains(dynamic /*Position|Range*/ positionOrRange);

  /// Check if `other` equals this range.
  /// start and end of this range.
  external bool isEqual(Range other);

  /// Intersect `range` with this range and returns a new range or `undefined`
  /// if the ranges have no overlap.
  /// return undefined when there is no overlap.
  external dynamic /*Range|dynamic*/ intersection(Range range);

  /// Compute the union of `other` with this range.
  external Range union(Range other);

  /// Derived a new range from this range.
  /// If start and end are not different `this` range will be returned.
  /*external Range JS$with([Position start, Position end]);*/
  /// Derived a new range from this range.
  /// is not changing anything.
  /*external Range JS$with({ start?: Position, end?: Position } change);*/
  external Range JS$with(
      [dynamic /*Position|{ start?: Position, end?: Position }*/ start_change,
      Position end]);
}

/// Represents a text selection in an editor.
@JS("vscode.Selection")
class Selection extends Range {
  // @Ignore
  Selection.fakeConstructor$() : super.fakeConstructor$();

  /// The position at which the selection starts.
  /// This position might be before or after [active](#Selection.active).
  external Position get anchor;
  external set anchor(Position v);

  /// The position of the cursor.
  /// This position might be before or after [anchor](#Selection.anchor).
  external Position get active;
  external set active(Position v);

  /// Create a selection from two postions.
  /*external factory Selection(Position anchor, Position active);*/
  /// Create a selection from four coordinates.
  /*external factory Selection(num anchorLine, num anchorCharacter, num activeLine, num activeCharacter);*/
  external factory Selection(dynamic /*Position|num*/ anchor_anchorLine,
      dynamic /*Position|num*/ active_anchorCharacter,
      [num activeLine, num activeCharacter]);

  /// A selection is reversed if [active](#Selection.active).isBefore([anchor](#Selection.anchor)).
  external bool get isReversed;
  external set isReversed(bool v);
}

/// Represents sources that can cause [selection change events](#window.onDidChangeTextEditorSelection).
@JS("vscode.TextEditorSelectionChangeKind")
class TextEditorSelectionChangeKind {
  external static num get

      /// Selection changed due to typing in the editor.
      Keyboard;
  external static num get

      /// Selection change due to clicking in the editor.
      Mouse;
  external static num get

      /// Selection changed because a command ran.
      Command;
}

/// Represents an event describing the change in a [text editor's selections](#TextEditor.selections).
@anonymous
@JS()
abstract class TextEditorSelectionChangeEvent {
  /// The [text editor](#TextEditor) for which the selections have changed.
  external TextEditor get textEditor;
  external set textEditor(TextEditor v);

  /// The new value for the [text editor's selections](#TextEditor.selections).
  external List<Selection> get selections;
  external set selections(List<Selection> v);

  /// The [change kind](#TextEditorSelectionChangeKind) which has triggered this
  /// event. Can be `undefined`.
  external num /*enum TextEditorSelectionChangeKind*/ get kind;
  external set kind(num /*enum TextEditorSelectionChangeKind*/ v);
  external factory TextEditorSelectionChangeEvent(
      {TextEditor textEditor,
      List<Selection> selections,
      num /*enum TextEditorSelectionChangeKind*/ kind});
}

/// Represents an event describing the change in a [text editor's options](#TextEditor.options).
@anonymous
@JS()
abstract class TextEditorOptionsChangeEvent {
  /// The [text editor](#TextEditor) for which the options have changed.
  external TextEditor get textEditor;
  external set textEditor(TextEditor v);

  /// The new value for the [text editor's options](#TextEditor.options).
  external TextEditorOptions get options;
  external set options(TextEditorOptions v);
  external factory TextEditorOptionsChangeEvent(
      {TextEditor textEditor, TextEditorOptions options});
}

/// Represents an event describing the change of a [text editor's view column](#TextEditor.viewColumn).
@anonymous
@JS()
abstract class TextEditorViewColumnChangeEvent {
  /// The [text editor](#TextEditor) for which the options have changed.
  external TextEditor get textEditor;
  external set textEditor(TextEditor v);

  /// The new value for the [text editor's view column](#TextEditor.viewColumn).
  external num /*enum ViewColumn*/ get viewColumn;
  external set viewColumn(num /*enum ViewColumn*/ v);
  external factory TextEditorViewColumnChangeEvent(
      {TextEditor textEditor, num /*enum ViewColumn*/ viewColumn});
}

/// Rendering style of the cursor.
@JS("vscode.TextEditorCursorStyle")
class TextEditorCursorStyle {
  external static num get

      /// Render the cursor as a vertical line.
      Line;
  external static num get

      /// Render the cursor as a block.
      Block;
  external static num get

      /// Render the cursor as a horizontal line under the character.
      Underline;
}

/// Rendering style of the line numbers.
@JS("vscode.TextEditorLineNumbersStyle")
class TextEditorLineNumbersStyle {
  external static num get

      /// Do not render the line numbers.
      Off;
  external static num get

      /// Render the line numbers.
      On;
  external static num get

      /// Render the line numbers with values relative to the primary cursor location.
      Relative;
}

/// Represents a [text editor](#TextEditor)'s [options](#TextEditor.options).
@anonymous
@JS()
abstract class TextEditorOptions {
  /// The size in spaces a tab takes. This is used for two purposes:
  /// - the rendering width of a tab character;
  /// - the number of spaces to insert when [insertSpaces](#TextEditorOptions.insertSpaces) is true.
  /// When getting a text editor's options, this property will always be a number (resolved).
  /// When setting a text editor's options, this property is optional and it can be a number or `"auto"`.
  external dynamic /*num|String*/ get tabSize;
  external set tabSize(dynamic /*num|String*/ v);

  /// When pressing Tab insert [n](#TextEditorOptions.tabSize) spaces.
  /// When getting a text editor's options, this property will always be a boolean (resolved).
  /// When setting a text editor's options, this property is optional and it can be a boolean or `"auto"`.
  external dynamic /*bool|String*/ get insertSpaces;
  external set insertSpaces(dynamic /*bool|String*/ v);

  /// The rendering style of the cursor in this editor.
  /// When getting a text editor's options, this property will always be present.
  /// When setting a text editor's options, this property is optional.
  external num /*enum TextEditorCursorStyle*/ get cursorStyle;
  external set cursorStyle(num /*enum TextEditorCursorStyle*/ v);

  /// Render relative line numbers w.r.t. the current line number.
  /// When getting a text editor's options, this property will always be present.
  /// When setting a text editor's options, this property is optional.
  external num /*enum TextEditorLineNumbersStyle*/ get lineNumbers;
  external set lineNumbers(num /*enum TextEditorLineNumbersStyle*/ v);
  external factory TextEditorOptions(
      {dynamic /*num|String*/ tabSize,
      dynamic /*bool|String*/ insertSpaces,
      num /*enum TextEditorCursorStyle*/ cursorStyle,
      num /*enum TextEditorLineNumbersStyle*/ lineNumbers});
}

/// Represents a handle to a set of decorations
/// sharing the same [styling options](#DecorationRenderOptions) in a [text editor](#TextEditor).
/// To get an instance of a `TextEditorDecorationType` use
/// [createTextEditorDecorationType](#window.createTextEditorDecorationType).
@anonymous
@JS()
abstract class TextEditorDecorationType {
  /// Internal representation of the handle.
  /// @readonly
  external String get key;
  external set key(String v);

  /// Remove this decoration type and all decorations on all text editors using it.
  external void dispose();
}

/// Represents different [reveal](#TextEditor.revealRange) strategies in a text editor.
@JS("vscode.TextEditorRevealType")
class TextEditorRevealType {
  external static num get

      /// The range will be revealed with as little scrolling as possible.
      Default;
  external static num get

      /// The range will always be revealed in the center of the viewport.
      InCenter;
  external static num get

      /// If the range is outside the viewport, it will be revealed in the center of the viewport.
      /// Otherwise, it will be revealed with as little scrolling as possible.
      InCenterIfOutsideViewport;
}

/// Represents different positions for rendering a decoration in an [overview ruler](#DecorationRenderOptions.overviewRulerLane).
/// The overview ruler supports three lanes.
@JS("vscode.OverviewRulerLane")
class OverviewRulerLane {
  external static num get Left;
  external static num get Center;
  external static num get Right;
  external static num get Full;
}

/// Represents theme specific rendering styles for a [text editor decoration](#TextEditorDecorationType).
@anonymous
@JS()
abstract class ThemableDecorationRenderOptions {
  /// Background color of the decoration. Use rgba() and define transparent background colors to play well with other decorations.
  external String get backgroundColor;
  external set backgroundColor(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get outline;
  external set outline(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'outline' for setting one or more of the individual outline properties.
  external String get outlineColor;
  external set outlineColor(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'outline' for setting one or more of the individual outline properties.
  external String get outlineStyle;
  external set outlineStyle(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'outline' for setting one or more of the individual outline properties.
  external String get outlineWidth;
  external set outlineWidth(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get border;
  external set border(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'border' for setting one or more of the individual border properties.
  external String get borderColor;
  external set borderColor(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'border' for setting one or more of the individual border properties.
  external String get borderRadius;
  external set borderRadius(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'border' for setting one or more of the individual border properties.
  external String get borderSpacing;
  external set borderSpacing(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'border' for setting one or more of the individual border properties.
  external String get borderStyle;
  external set borderStyle(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  /// Better use 'border' for setting one or more of the individual border properties.
  external String get borderWidth;
  external set borderWidth(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get textDecoration;
  external set textDecoration(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get cursor;
  external set cursor(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get color;
  external set color(String v);

  /// CSS styling property that will be applied to text enclosed by a decoration.
  external String get letterSpacing;
  external set letterSpacing(String v);

  /// An **absolute path** or an URI to an image to be rendered in the gutter.
  external dynamic /*String|Uri*/ get gutterIconPath;
  external set gutterIconPath(dynamic /*String|Uri*/ v);

  /// Specifies the size of the gutter icon.
  /// Available values are 'auto', 'contain', 'cover' and any percentage value.
  /// For further information: https://msdn.microsoft.com/en-us/library/jj127316(v=vs.85).aspx
  external String get gutterIconSize;
  external set gutterIconSize(String v);

  /// The color of the decoration in the overview ruler. Use rgba() and define transparent colors to play well with other decorations.
  external String get overviewRulerColor;
  external set overviewRulerColor(String v);

  /// Defines the rendering options of the attachment that is inserted before the decorated text
  external ThemableDecorationAttachmentRenderOptions get before;
  external set before(ThemableDecorationAttachmentRenderOptions v);

  /// Defines the rendering options of the attachment that is inserted after the decorated text
  external ThemableDecorationAttachmentRenderOptions get after;
  external set after(ThemableDecorationAttachmentRenderOptions v);
  external factory ThemableDecorationRenderOptions(
      {String backgroundColor,
      String outline,
      String outlineColor,
      String outlineStyle,
      String outlineWidth,
      String border,
      String borderColor,
      String borderRadius,
      String borderSpacing,
      String borderStyle,
      String borderWidth,
      String textDecoration,
      String cursor,
      String color,
      String letterSpacing,
      dynamic /*String|Uri*/ gutterIconPath,
      String gutterIconSize,
      String overviewRulerColor,
      ThemableDecorationAttachmentRenderOptions before,
      ThemableDecorationAttachmentRenderOptions after});
}

@anonymous
@JS()
abstract class ThemableDecorationAttachmentRenderOptions {
  /// Defines a text content that is shown in the attachment. Either an icon or a text can be shown, but not both.
  external String get contentText;
  external set contentText(String v);

  /// An **absolute path** or an URI to an image to be rendered in the attachment. Either an icon
  /// or a text can be shown, but not both.
  external dynamic /*String|Uri*/ get contentIconPath;
  external set contentIconPath(dynamic /*String|Uri*/ v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get border;
  external set border(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get textDecoration;
  external set textDecoration(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get color;
  external set color(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get backgroundColor;
  external set backgroundColor(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get margin;
  external set margin(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get width;
  external set width(String v);

  /// CSS styling property that will be applied to the decoration attachment.
  external String get height;
  external set height(String v);
  external factory ThemableDecorationAttachmentRenderOptions(
      {String contentText,
      dynamic /*String|Uri*/ contentIconPath,
      String border,
      String textDecoration,
      String color,
      String backgroundColor,
      String margin,
      String width,
      String height});
}

/// Represents rendering styles for a [text editor decoration](#TextEditorDecorationType).
@anonymous
@JS()
abstract class DecorationRenderOptions
    implements ThemableDecorationRenderOptions {
  /// Should the decoration be rendered also on the whitespace after the line text.
  /// Defaults to `false`.
  external bool get isWholeLine;
  external set isWholeLine(bool v);

  /// The position in the overview ruler where the decoration should be rendered.
  external num /*enum OverviewRulerLane*/ get overviewRulerLane;
  external set overviewRulerLane(num /*enum OverviewRulerLane*/ v);

  /// Overwrite options for light themes.
  external ThemableDecorationRenderOptions get light;
  external set light(ThemableDecorationRenderOptions v);

  /// Overwrite options for dark themes.
  external ThemableDecorationRenderOptions get dark;
  external set dark(ThemableDecorationRenderOptions v);
  external factory DecorationRenderOptions(
      {bool isWholeLine,
      num /*enum OverviewRulerLane*/ overviewRulerLane,
      ThemableDecorationRenderOptions light,
      ThemableDecorationRenderOptions dark,
      String backgroundColor,
      String outline,
      String outlineColor,
      String outlineStyle,
      String outlineWidth,
      String border,
      String borderColor,
      String borderRadius,
      String borderSpacing,
      String borderStyle,
      String borderWidth,
      String textDecoration,
      String cursor,
      String color,
      String letterSpacing,
      dynamic /*String|Uri*/ gutterIconPath,
      String gutterIconSize,
      String overviewRulerColor,
      ThemableDecorationAttachmentRenderOptions before,
      ThemableDecorationAttachmentRenderOptions after});
}

/// Represents options for a specific decoration in a [decoration set](#TextEditorDecorationType).
@anonymous
@JS()
abstract class DecorationOptions {
  /// Range to which this decoration is applied. The range must not be empty.
  external Range get range;
  external set range(Range v);

  /// A message that should be rendered when hovering over the decoration.
  external dynamic /*String|{ language: string; value: string }|List<String|{ language: string; value: string }>*/ get hoverMessage;
  external set hoverMessage(
      dynamic /*String|{ language: string; value: string }|List<String|{ language: string; value: string }>*/ v);

  /// Render options applied to the current decoration. For performance reasons, keep the
  /// number of decoration specific options small, and use decoration types whereever possible.
  external DecorationInstanceRenderOptions get renderOptions;
  external set renderOptions(DecorationInstanceRenderOptions v);
  external factory DecorationOptions(
      {Range range,
      dynamic /*String|{ language: string; value: string }|List<String|{ language: string; value: string }>*/ hoverMessage,
      DecorationInstanceRenderOptions renderOptions});
}

@anonymous
@JS()
abstract class ThemableDecorationInstanceRenderOptions {
  /// Defines the rendering options of the attachment that is inserted before the decorated text
  external ThemableDecorationAttachmentRenderOptions get before;
  external set before(ThemableDecorationAttachmentRenderOptions v);

  /// Defines the rendering options of the attachment that is inserted after the decorated text
  external ThemableDecorationAttachmentRenderOptions get after;
  external set after(ThemableDecorationAttachmentRenderOptions v);
  external factory ThemableDecorationInstanceRenderOptions(
      {ThemableDecorationAttachmentRenderOptions before,
      ThemableDecorationAttachmentRenderOptions after});
}

@anonymous
@JS()
abstract class DecorationInstanceRenderOptions
    implements ThemableDecorationInstanceRenderOptions {
  /// Overwrite options for light themes.
  external ThemableDecorationInstanceRenderOptions get light;
  external set light(ThemableDecorationInstanceRenderOptions v);

  /// Overwrite options for dark themes.
  external ThemableDecorationInstanceRenderOptions get dark;
  external set dark(ThemableDecorationInstanceRenderOptions v);
  external factory DecorationInstanceRenderOptions(
      {ThemableDecorationInstanceRenderOptions light,
      ThemableDecorationInstanceRenderOptions dark,
      ThemableDecorationAttachmentRenderOptions before,
      ThemableDecorationAttachmentRenderOptions after});
}

/// Represents an editor that is attached to a [document](#TextDocument).
@anonymous
@JS()
abstract class TextEditor {
  /// The document associated with this text editor. The document will be the same for the entire lifetime of this text editor.
  external TextDocument get document;
  external set document(TextDocument v);

  /// The primary selection on this text editor. Shorthand for `TextEditor.selections[0]`.
  external Selection get selection;
  external set selection(Selection v);

  /// The selections in this text editor. The primary selection is always at index 0.
  external List<Selection> get selections;
  external set selections(List<Selection> v);

  /// Text editor options.
  external TextEditorOptions get options;
  external set options(TextEditorOptions v);

  /// The column in which this editor shows. Will be `undefined` in case this
  /// isn't one of the three main editors, e.g an embedded editor.
  external num /*enum ViewColumn*/ get viewColumn;
  external set viewColumn(num /*enum ViewColumn*/ v);

  /// Perform an edit on the document associated with this text editor.
  /// The given callback-function is invoked with an [edit-builder](#TextEditorEdit) which must
  /// be used to make edits. Note that the edit-builder is only valid while the
  /// callback executes.
  external Thenable<bool> edit(void callback(TextEditorEdit editBuilder),
      [dynamic /*{ undoStopBefore: boolean; undoStopAfter: boolean; }*/ options]);

  /// Adds a set of decorations to the text editor. If a set of decorations already exists with
  /// the given [decoration type](#TextEditorDecorationType), they will be replaced.
  /// @see [createTextEditorDecorationType](#window.createTextEditorDecorationType).
  external void setDecorations(TextEditorDecorationType decorationType,
      List<dynamic> /*List<Range>|List<DecorationOptions>*/ rangesOrOptions);

  /// Scroll as indicated by `revealType` in order to reveal the given range.
  external void revealRange(Range range,
      [num /*enum TextEditorRevealType*/ revealType]);

  /// Show the text editor.
  /// **This method is deprecated.** Use [window.showTextDocument](#window.showTextDocument)
  /// instead. This method shows unexpected behavior and will be removed in the next major update.
  external void show([num /*enum ViewColumn*/ column]);

  /// Hide the text editor.
  /// **This method is deprecated.** Use the command 'workbench.action.closeActiveEditor' instead.
  /// This method shows unexpected behavior and will be removed in the next major update.
  external void hide();
}

/// Represents an end of line character sequence in a [document](#TextDocument).
@JS("vscode.EndOfLine")
class EndOfLine {
  external static num get

      /// The line feed `\n` character.
      LF;
  external static num get

      /// The carriage return line feed `\r\n` sequence.
      CRLF;
}

/// A complex edit that will be applied in one transaction on a TextEditor.
/// This holds a description of the edits and if the edits are valid (i.e. no overlapping regions, document was not changed in the meantime, etc.)
/// they can be applied on a [document](#TextDocument) associated with a [text editor](#TextEditor).
@anonymous
@JS()
abstract class TextEditorEdit {
  /// Replace a certain text region with a new value.
  /// You can use \r\n or \n in `value` and they will be normalized to the current [document](#TextDocument).
  external void replace(
      dynamic /*Position|Range|Selection*/ location, String value);

  /// Insert text at a location.
  /// You can use \r\n or \n in `value` and they will be normalized to the current [document](#TextDocument).
  /// Although the equivalent text edit can be made with [replace](#TextEditorEdit.replace), `insert` will produce a different resulting selection (it will get moved).
  external void insert(Position location, String value);

  /// Delete a certain text region.
  external void delete(dynamic /*Range|Selection*/ location);

  /// Set the end of line sequence.
  external void setEndOfLine(num /*enum EndOfLine*/ endOfLine);
}

/// A universal resource identifier representing either a file on disk
/// or another resource, like untitled resources.
@JS("vscode.Uri")
class Uri {
  // @Ignore
  Uri.fakeConstructor$();

  /// Create an URI from a file system path. The [scheme](#Uri.scheme)
  /// will be `file`.
  external static Uri file(String path);

  /// Create an URI from a string. Will throw if the given value is not
  /// valid.
  external static Uri parse(String value);

  /// Scheme is the `http` part of `http://www.msft.com/some/path?query#fragment`.
  /// The part before the first colon.
  external String get scheme;
  external set scheme(String v);

  /// Authority is the `www.msft.com` part of `http://www.msft.com/some/path?query#fragment`.
  /// The part between the first double slashes and the next slash.
  external String get authority;
  external set authority(String v);

  /// Path is the `/some/path` part of `http://www.msft.com/some/path?query#fragment`.
  external String get path;
  external set path(String v);

  /// Query is the `query` part of `http://www.msft.com/some/path?query#fragment`.
  external String get query;
  external set query(String v);

  /// Fragment is the `fragment` part of `http://www.msft.com/some/path?query#fragment`.
  external String get fragment;
  external set fragment(String v);

  /// The string representing the corresponding file system path of this Uri.
  /// Will handle UNC paths and normalize windows drive letters to lower-case. Also
  /// uses the platform specific path separator. Will *not* validate the path for
  /// invalid characters and semantics. Will *not* look at the scheme of this Uri.
  external String get fsPath;
  external set fsPath(String v);

  /// Derive a new Uri from this Uri.
  /// the empty string.
  /// is not changing anything.
  /// @sample ```
  /// let file = Uri.parse('before:some/file/path');
  /// let other = file.with({ scheme: 'after' });
  /// assert.ok(other.toString() === 'after:some/file/path');
  /// ```
  external Uri JS$with(
      dynamic /*{ scheme?: string; authority?: string; path?: string; query?: string; fragment?: string }*/ change);

  /// Returns a string representation of this Uri. The representation and normalization
  /// of a URI depends on the scheme. The resulting string can be safely used with
  /// [Uri.parse](#Uri.parse).
  /// the `#` and `?` characters occuring in the path will always be encoded.
  external String toString([bool skipEncoding]);

  /// Returns a JSON representation of this Uri.
  external dynamic toJSON();
}

/// A cancellation token is passed to an asynchronous or long running
/// operation to request cancellation, like cancelling a request
/// for completion items because the user continued to type.
/// To get an instance of a `CancellationToken` use a
/// [CancellationTokenSource](#CancellationTokenSource).
@anonymous
@JS()
abstract class CancellationToken {
  /// Is `true` when the token has been cancelled, `false` otherwise.
  external bool get isCancellationRequested;
  external set isCancellationRequested(bool v);

  /// An [event](#Event) which fires upon cancellation.
  external Event<dynamic> get onCancellationRequested;
  external set onCancellationRequested(Event<dynamic> v);
  external factory CancellationToken(
      {bool isCancellationRequested, Event<dynamic> onCancellationRequested});
}

/// A cancellation source creates and controls a [cancellation token](#CancellationToken).
@JS("vscode.CancellationTokenSource")
class CancellationTokenSource {
  // @Ignore
  CancellationTokenSource.fakeConstructor$();

  /// The cancellation token of this source.
  external CancellationToken get token;
  external set token(CancellationToken v);

  /// Signal cancellation on the token.
  external void cancel();

  /// Dispose object and free resources. Will call [cancel](#CancellationTokenSource.cancel).
  external void dispose();
}

/// Represents a type which can release resources, such
/// as event listening or a timer.
@JS("vscode.Disposable")
class Disposable {
  // @Ignore
  Disposable.fakeConstructor$();

  /// Combine many disposable-likes into one. Use this method
  /// when having objects with a dispose function which are not
  /// instances of Disposable.
  /// dispose all provided disposables.
  external static Disposable from(
      [dynamic /*{ dispose: () => any }*/ disposableLikes1,
      dynamic /*{ dispose: () => any }*/ disposableLikes2,
      dynamic /*{ dispose: () => any }*/ disposableLikes3,
      dynamic /*{ dispose: () => any }*/ disposableLikes4,
      dynamic /*{ dispose: () => any }*/ disposableLikes5]);

  /// Creates a new Disposable calling the provided function
  /// on dispose.
  external factory Disposable(Function callOnDispose);

  /// Dispose this object.
  external dynamic dispose();
}

/// Represents a typed event.
/// A function that represents an event to which you subscribe by calling it with
/// a listener function as argument.
/// @sample `item.onDidChange(function(event) { console.log("Event happened: " + event); });`
typedef Disposable Event<T>(dynamic listener(T e),
    [dynamic thisArgs, List<Disposable> disposables]);

/// An event emitter can be used to create and manage an [event](#Event) for others
/// to subscribe to. One emitter always owns one event.
/// Use this class if you want to provide event from within your extension, for instance
/// inside a [TextDocumentContentProvider](#TextDocumentContentProvider) or when providing
/// API to other extensions.
@JS("vscode.EventEmitter")
class EventEmitter<T> {
  // @Ignore
  EventEmitter.fakeConstructor$();

  /// The event listeners can subscribe to.
  external Event<T> get event;
  external set event(Event<T> v);

  /// Notify all subscribers of the [event](EventEmitter#event). Failure
  /// of one or more listener will not fail this function call.
  external void fire([T data]);

  /// Dispose this object and free resources.
  external void dispose();
}

/// A file system watcher notifies about changes to files and folders
/// on disk.
/// To get an instance of a `FileSystemWatcher` use
/// [createFileSystemWatcher](#workspace.createFileSystemWatcher).
@anonymous
@JS()
abstract class FileSystemWatcher implements Disposable {
  /// true if this file system watcher has been created such that
  /// it ignores creation file system events.
  external bool get ignoreCreateEvents;
  external set ignoreCreateEvents(bool v);

  /// true if this file system watcher has been created such that
  /// it ignores change file system events.
  external bool get ignoreChangeEvents;
  external set ignoreChangeEvents(bool v);

  /// true if this file system watcher has been created such that
  /// it ignores delete file system events.
  external bool get ignoreDeleteEvents;
  external set ignoreDeleteEvents(bool v);

  /// An event which fires on file/folder creation.
  external Event<Uri> get onDidCreate;
  external set onDidCreate(Event<Uri> v);

  /// An event which fires on file/folder change.
  external Event<Uri> get onDidChange;
  external set onDidChange(Event<Uri> v);

  /// An event which fires on file/folder deletion.
  external Event<Uri> get onDidDelete;
  external set onDidDelete(Event<Uri> v);
}

/// A text document content provider allows to add readonly documents
/// to the editor, such as source from a dll or generated html from md.
/// Content providers are [registered](#workspace.registerTextDocumentContentProvider)
/// for a [uri-scheme](#Uri.scheme). When a uri with that scheme is to
/// be [loaded](#workspace.openTextDocument) the content provider is
/// asked.
@anonymous
@JS()
abstract class TextDocumentContentProvider {
  /// An event to signal a resource has changed.
  external Event<Uri> get onDidChange;
  external set onDidChange(Event<Uri> v);

  /// Provide textual content for a given uri.
  /// The editor will use the returned string-content to create a readonly
  /// [document](TextDocument). Resources allocated should be released when
  /// the corresponding document has been [closed](#workspace.onDidCloseTextDocument).
  external dynamic /*String|dynamic|Null|Thenable<String|dynamic|Null>*/ provideTextDocumentContent(
      Uri uri, CancellationToken token);
}

/// Represents an item that can be selected from
/// a list of items.
@anonymous
@JS()
abstract class QuickPickItem {
  /// A human readable string which is rendered prominent.
  external String get label;
  external set label(String v);

  /// A human readable string which is rendered less prominent.
  external String get description;
  external set description(String v);

  /// A human readable string which is rendered less prominent.
  external String get detail;
  external set detail(String v);
  external factory QuickPickItem(
      {String label, String description, String detail});
}

/// Options to configure the behavior of the quick pick UI.
@anonymous
@JS()
abstract class QuickPickOptions {
  /// An optional flag to include the description when filtering the picks.
  external bool get matchOnDescription;
  external set matchOnDescription(bool v);

  /// An optional flag to include the detail when filtering the picks.
  external bool get matchOnDetail;
  external set matchOnDetail(bool v);

  /// An optional string to show as place holder in the input box to guide the user what to pick on.
  external String get placeHolder;
  external set placeHolder(String v);

  /// Set to `true` to keep the picker open when focus moves to another part of the editor or to another window.
  external bool get ignoreFocusOut;
  external set ignoreFocusOut(bool v);

  /// An optional function that is invoked whenever an item is selected.
  external dynamic onDidSelectItem/*<T extends QuickPickItem>*/(
      dynamic /*T|String*/ item);
}

/// Represents an action that is shown with an information, warning, or
/// error message.
/// @see [showInformationMessage](#window.showInformationMessage)
/// @see [showWarningMessage](#window.showWarningMessage)
/// @see [showErrorMessage](#window.showErrorMessage)
@anonymous
@JS()
abstract class MessageItem {
  /// A short title like 'Retry', 'Open Log' etc.
  external String get title;
  external set title(String v);

  /// Indicates that this item replaces the default
  /// 'Close' action.
  external bool get isCloseAffordance;
  external set isCloseAffordance(bool v);
  external factory MessageItem({String title, bool isCloseAffordance});
}

/// Options to configure the behavior of the input box UI.
@anonymous
@JS()
abstract class InputBoxOptions {
  /// The value to prefill in the input box.
  external String get value;
  external set value(String v);

  /// The text to display underneath the input box.
  external String get prompt;
  external set prompt(String v);

  /// An optional string to show as place holder in the input box to guide the user what to type.
  external String get placeHolder;
  external set placeHolder(String v);

  /// Set to `true` to show a password prompt that will not show the typed value.
  external bool get password;
  external set password(bool v);

  /// Set to `true` to keep the input box open when focus moves to another part of the editor or to another window.
  external bool get ignoreFocusOut;
  external set ignoreFocusOut(bool v);

  /// An optional function that will be called to validate input and to give a hint
  /// to the user.
  /// Return `undefined`, `null`, or the empty string when 'value' is valid.
  external dynamic /*String|dynamic|Null*/ validateInput(String value);
}

/// A document filter denotes a document by different properties like
/// the [language](#TextDocument.languageId), the [scheme](#Uri.scheme) of
/// its resource, or a glob-pattern that is applied to the [path](#TextDocument.fileName).
/// @sample A language filter that applies to typescript files on disk: `{ language: 'typescript', scheme: 'file' }`
/// @sample A language filter that applies to all package.json paths: `{ language: 'json', pattern: '**∕project.json' }`
@anonymous
@JS()
abstract class DocumentFilter {
  /// A language id, like `typescript`.
  external String get language;
  external set language(String v);

  /// A Uri [scheme](#Uri.scheme), like `file` or `untitled`.
  external String get scheme;
  external set scheme(String v);

  /// A glob pattern, like `*.{ts,js}`.
  external String get pattern;
  external set pattern(String v);
  external factory DocumentFilter(
      {String language, String scheme, String pattern});
}

/// A language selector is the combination of one or many language identifiers
/// and [language filters](#DocumentFilter).
/// @sample `let sel:DocumentSelector = 'typescript'`;
/// @sample `let sel:DocumentSelector = ['typescript', { language: 'json', pattern: '**∕tsconfig.json' }]`;
/*export type DocumentSelector = string | DocumentFilter | (string | DocumentFilter)[];*/
/// A provider result represents the values a provider, like the [`HoverProvider`](#HoverProvider),
/// may return. For once this is the actual result type `T`, like `Hover`, or a thenable that resolves
/// to that type `T`. In addition, `null` and `undefined` can be returned - either directly or from a
/// thenable.
/// The snippets below are all valid implementions of the [`HoverProvider`](#HoverProvider):
/// ```ts
/// let a: HoverProvider = {
/// provideHover(doc, pos, token): ProviderResult<Hover> {
/// return new Hover('Hello World');
/// }
/// }
/// let b: HoverProvider = {
/// provideHover(doc, pos, token): ProviderResult<Hover> {
/// return new Promise(resolve => {
/// resolve(new Hover('Hello World'));
/// });
/// }
/// }
/// let c: HoverProvider = {
/// provideHover(doc, pos, token): ProviderResult<Hover> {
/// return; // undefined
/// }
/// }
/// ```
/*export type ProviderResult<T> = T | undefined | null | Thenable<T | undefined | null>*/
/// Contains additional diagnostic information about the context in which
/// a [code action](#CodeActionProvider.provideCodeActions) is run.
@anonymous
@JS()
abstract class CodeActionContext {
  /// An array of diagnostics.
  /// @readonly
  external List<Diagnostic> get diagnostics;
  external set diagnostics(List<Diagnostic> v);
  external factory CodeActionContext({List<Diagnostic> diagnostics});
}

/// The code action interface defines the contract between extensions and
/// the [light bulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action) feature.
/// A code action can be any command that is [known](#commands.getCommands) to the system.
@anonymous
@JS()
abstract class CodeActionProvider {
  /// Provide commands for the given document and range.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<Command>|dynamic|Null|Thenable<List<Command>|dynamic|Null>*/ provideCodeActions(
      TextDocument document,
      Range range,
      CodeActionContext context,
      CancellationToken token);
}

/// A code lens represents a [command](#Command) that should be shown along with
/// source text, like the number of references, a way to run tests, etc.
/// A code lens is _unresolved_ when no command is associated to it. For performance
/// reasons the creation of a code lens and resolving should be done to two stages.
/// @see [CodeLensProvider.provideCodeLenses](#CodeLensProvider.provideCodeLenses)
/// @see [CodeLensProvider.resolveCodeLens](#CodeLensProvider.resolveCodeLens)
@JS("vscode.CodeLens")
class CodeLens {
  // @Ignore
  CodeLens.fakeConstructor$();

  /// The range in which this code lens is valid. Should only span a single line.
  external Range get range;
  external set range(Range v);

  /// The command this code lens represents.
  external Command get command;
  external set command(Command v);

  /// `true` when there is a command associated.
  /// @readonly
  external bool get isResolved;
  external set isResolved(bool v);

  /// Creates a new code lens object.
  external factory CodeLens(Range range, [Command command]);
}

/// A code lens provider adds [commands](#Command) to source text. The commands will be shown
/// as dedicated horizontal lines in between the source text.
@anonymous
@JS()
abstract class CodeLensProvider {
  /// Compute a list of [lenses](#CodeLens). This call should return as fast as possible and if
  /// computing the commands is expensive implementors should only return code lens objects with the
  /// range set and implement [resolve](#CodeLensProvider.resolveCodeLens).
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<CodeLens>|dynamic|Null|Thenable<List<CodeLens>|dynamic|Null>*/ provideCodeLenses(
      TextDocument document, CancellationToken token);

  /// This function will be called for each visible code lens, usually when scrolling and after
  /// calls to [compute](#CodeLensProvider.provideCodeLenses)-lenses.
  external dynamic /*CodeLens|dynamic|Null|Thenable<CodeLens|dynamic|Null>*/ resolveCodeLens(
      CodeLens codeLens, CancellationToken token);
}

/// The definition of a symbol represented as one or many [locations](#Location).
/// For most programming languages there is only one location at which a symbol is
/// defined.
/*export type Definition = Location | Location[];*/
/// The definition provider interface defines the contract between extensions and
/// the [go to definition](https://code.visualstudio.com/docs/editor/editingevolved#_go-to-definition)
/// and peek definition features.
@anonymous
@JS()
abstract class DefinitionProvider {
  /// Provide the definition of the symbol at the given position and document.
  /// signaled by returning `undefined` or `null`.
  external dynamic /*Location|List<Location>|dynamic|Null|Thenable<Location|List<Location>|dynamic|Null>*/ provideDefinition(
      TextDocument document, Position position, CancellationToken token);
}

/// MarkedString can be used to render human readable text. It is either a markdown string
/// or a code-block that provides a language and a code snippet. Note that
/// markdown strings will be sanitized - that means html will be escaped.
/*export type MarkedString = string | { language: string; value: string };*/
/// A hover represents additional information for a symbol or word. Hovers are
/// rendered in a tooltip-like widget.
@JS("vscode.Hover")
class Hover {
  // @Ignore
  Hover.fakeConstructor$();

  /// The contents of this hover.
  external List<dynamic /*String|{ language: string; value: string }*/ >
      get contents;
  external set contents(
      List<dynamic /*String|{ language: string; value: string }*/ > v);

  /// The range to which this hover applies. When missing, the
  /// editor will use the range at the current position or the
  /// current position itself.
  external Range get range;
  external set range(Range v);

  /// Creates a new hover object.
  external factory Hover(
      dynamic /*String|{ language: string; value: string }|List<String|{ language: string; value: string }>*/ contents,
      [Range range]);
}

/// The hover provider interface defines the contract between extensions and
/// the [hover](https://code.visualstudio.com/docs/editor/editingevolved#_hover)-feature.
@anonymous
@JS()
abstract class HoverProvider {
  /// Provide a hover for the given position and document. Multiple hovers at the same
  /// position will be merged by the editor. A hover can have a range which defaults
  /// to the word range at the position when omitted.
  /// signaled by returning `undefined` or `null`.
  external dynamic /*Hover|dynamic|Null|Thenable<Hover|dynamic|Null>*/ provideHover(
      TextDocument document, Position position, CancellationToken token);
}

/// A document highlight kind.
@JS("vscode.DocumentHighlightKind")
class DocumentHighlightKind {
  external static num get

      /// A textual occurrence.
      Text;
  external static num get

      /// Read-access of a symbol, like reading a variable.
      Read;
  external static num get

      /// Write-access of a symbol, like writing to a variable.
      Write;
}

/// A document highlight is a range inside a text document which deserves
/// special attention. Usually a document highlight is visualized by changing
/// the background color of its range.
@JS("vscode.DocumentHighlight")
class DocumentHighlight {
  // @Ignore
  DocumentHighlight.fakeConstructor$();

  /// The range this highlight applies to.
  external Range get range;
  external set range(Range v);

  /// The highlight kind, default is [text](#DocumentHighlightKind.Text).
  external num /*enum DocumentHighlightKind*/ get kind;
  external set kind(num /*enum DocumentHighlightKind*/ v);

  /// Creates a new document highlight object.
  external factory DocumentHighlight(Range range,
      [num /*enum DocumentHighlightKind*/ kind]);
}

/// The document highlight provider interface defines the contract between extensions and
/// the word-highlight-feature.
@anonymous
@JS()
abstract class DocumentHighlightProvider {
  /// Provide a set of document highlights, like all occurrences of a variable or
  /// all exit-points of a function.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<DocumentHighlight>|dynamic|Null|Thenable<List<DocumentHighlight>|dynamic|Null>*/ provideDocumentHighlights(
      TextDocument document, Position position, CancellationToken token);
}

/// A symbol kind.
@JS("vscode.SymbolKind")
class SymbolKind {
  external static num get File;
  external static num get Module;
  external static num get Namespace;
  external static num get Package;
  external static num get Class;
  external static num get Method;
  external static num get Property;
  external static num get Field;
  external static num get Constructor;
  external static num get Enum;
  external static num get Interface;
  external static num get Function;
  external static num get Variable;
  external static num get Constant;
  external static num get String;
  external static num get Number;
  external static num get Boolean;
  external static num get Array;
  external static num get Object;
  external static num get Key;
  external static num get Null;
}

/// Represents information about programming constructs like variables, classes,
/// interfaces etc.
@JS("vscode.SymbolInformation")
class SymbolInformation {
  // @Ignore
  SymbolInformation.fakeConstructor$();

  /// The name of this symbol.
  external String get name;
  external set name(String v);

  /// The name of the symbol containing this symbol.
  external String get containerName;
  external set containerName(String v);

  /// The kind of this symbol.
  external num /*enum SymbolKind*/ get kind;
  external set kind(num /*enum SymbolKind*/ v);

  /// The location of this symbol.
  external Location get location;
  external set location(Location v);

  /// Creates a new symbol information object.
  /*external factory SymbolInformation(String name, enum SymbolKind kind, String containerName, Location location);*/
  /// Please use the constructor taking a [location](#Location) object.
  /// Creates a new symbol information object.
  /*external factory SymbolInformation(String name, enum SymbolKind kind, Range range, [Uri uri, String containerName]);*/
  external factory SymbolInformation(String name, num /*enum SymbolKind*/ kind,
      dynamic /*String|Range*/ containerName_range,
      [dynamic /*Location|Uri*/ location_uri, String containerName]);
}

/// The document symbol provider interface defines the contract between extensions and
/// the [go to symbol](https://code.visualstudio.com/docs/editor/editingevolved#_goto-symbol)-feature.
@anonymous
@JS()
abstract class DocumentSymbolProvider {
  /// Provide symbol information for the given document.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<SymbolInformation>|dynamic|Null|Thenable<List<SymbolInformation>|dynamic|Null>*/ provideDocumentSymbols(
      TextDocument document, CancellationToken token);
}

/// The workspace symbol provider interface defines the contract between extensions and
/// the [symbol search](https://code.visualstudio.com/docs/editor/editingevolved#_open-symbol-by-name)-feature.
@anonymous
@JS()
abstract class WorkspaceSymbolProvider {
  /// Project-wide search for a symbol matching the given query string. It is up to the provider
  /// how to search given the query string, like substring, indexOf etc. To improve performance implementors can
  /// skip the [location](#SymbolInformation.location) of symbols and implement `resolveWorkspaceSymbol` to do that
  /// later.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<SymbolInformation>|dynamic|Null|Thenable<List<SymbolInformation>|dynamic|Null>*/ provideWorkspaceSymbols(
      String query, CancellationToken token);

  /// Given a symbol fill in its [location](#SymbolInformation.location). This method is called whenever a symbol
  /// is selected in the UI. Providers can implement this method and return incomplete symbols from
  /// [`provideWorkspaceSymbols`](#WorkspaceSymbolProvider.provideWorkspaceSymbols) which often helps to improve
  /// performance.
  /// earlier call to `provideWorkspaceSymbols`.
  /// the given `symbol` is used.
  external dynamic /*SymbolInformation|dynamic|Null|Thenable<SymbolInformation|dynamic|Null>*/ resolveWorkspaceSymbol(
      SymbolInformation symbol, CancellationToken token);
}

/// Value-object that contains additional information when
/// requesting references.
@anonymous
@JS()
abstract class ReferenceContext {
  /// Include the declaration of the current symbol.
  external bool get includeDeclaration;
  external set includeDeclaration(bool v);
  external factory ReferenceContext({bool includeDeclaration});
}

/// The reference provider interface defines the contract between extensions and
/// the [find references](https://code.visualstudio.com/docs/editor/editingevolved#_peek)-feature.
@anonymous
@JS()
abstract class ReferenceProvider {
  /// Provide a set of project-wide references for the given position and document.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<Location>|dynamic|Null|Thenable<List<Location>|dynamic|Null>*/ provideReferences(
      TextDocument document,
      Position position,
      ReferenceContext context,
      CancellationToken token);
}

/// A text edit represents edits that should be applied
/// to a document.
@JS("vscode.TextEdit")
class TextEdit {
  // @Ignore
  TextEdit.fakeConstructor$();

  /// Utility to create a replace edit.
  external static TextEdit replace(Range range, String newText);

  /// Utility to create an insert edit.
  external static TextEdit insert(Position position, String newText);

  /// Utility to create a delete edit.
  external static TextEdit delete(Range range);

  /// The range this edit applies to.
  external Range get range;
  external set range(Range v);

  /// The string this edit will insert.
  external String get newText;
  external set newText(String v);

  /// Create a new TextEdit.
  external factory TextEdit(Range range, String newText);
}

/// A workspace edit represents textual changes for many documents.
@JS("vscode.WorkspaceEdit")
class WorkspaceEdit {
  // @Ignore
  WorkspaceEdit.fakeConstructor$();

  /// The number of affected resources.
  /// @readonly
  external num get size;
  external set size(num v);

  /// Replace the given range with given text for the given resource.
  external void replace(Uri uri, Range range, String newText);

  /// Insert the given text at the given position.
  external void insert(Uri uri, Position position, String newText);

  /// Delete the text at the given range.
  external void delete(Uri uri, Range range);

  /// Check if this edit affects the given resource.
  external bool has(Uri uri);

  /// Set (and replace) text edits for a resource.
  external void JS$set(Uri uri, List<TextEdit> edits);

  /// Get the text edits for a resource.
  external List<TextEdit> JS$get(Uri uri);

  /// Get all text edits grouped by resource.
  external List<
          List<
              dynamic /*Uri|List<TextEdit>*/ > /*Tuple of <Uri,List<TextEdit>>*/ >
      entries();
}

/// A snippet string is a template which allows to insert text
/// and to control the editor cursor when insertion happens.
/// A snippet can define tab stops and placeholders with `$1`, `$2`
/// and `${3:foo}`. `$0` defines the final tab stop, it defaults to
/// the end of the snippet. Variables are defined with `$name` and
/// `${name:default value}`. The full snippet syntax is documented
/// [here](http://code.visualstudio.com/docs/customization/userdefinedsnippets#_creating-your-own-snippets).
@JS("vscode.SnippetString")
class SnippetString {
  // @Ignore
  SnippetString.fakeConstructor$();

  /// The snippet string.
  external String get value;
  external set value(String v);
  external factory SnippetString([String value]);

  /// Builder-function that appends the given string to
  /// the [`value`](#SnippetString.value) of this snippet string.
  external SnippetString appendText(String string);

  /// Builder-function that appends a tabstop (`$1`, `$2` etc) to
  /// the [`value`](#SnippetString.value) of this snippet string.
  /// value starting at 1.
  external SnippetString appendTabstop([num number]);

  /// Builder-function that appends a placeholder (`${1:value}`) to
  /// the [`value`](#SnippetString.value) of this snippet string.
  /// with which a nested snippet can be created.
  /// value starting at 1.
  external SnippetString appendPlaceholder(
      dynamic /*String|Func1<SnippetString, dynamic>*/ value,
      [num number]);

  /// Builder-function that appends a variable (`${VAR}`) to
  /// the [`value`](#SnippetString.value) of this snippet string.
  /// be resolved - either a string or a function with which a nested snippet can be created.
  external SnippetString appendVariable(String name,
      dynamic /*String|Func1<SnippetString, dynamic>*/ defaultValue);
}

/// The rename provider interface defines the contract between extensions and
/// the [rename](https://code.visualstudio.com/docs/editor/editingevolved#_rename-symbol)-feature.
@anonymous
@JS()
abstract class RenameProvider {
  /// Provide an edit that describes changes that have to be made to one
  /// or many resources to rename a symbol to a different name.
  /// signaled by returning `undefined` or `null`.
  external dynamic /*WorkspaceEdit|dynamic|Null|Thenable<WorkspaceEdit|dynamic|Null>*/ provideRenameEdits(
      TextDocument document,
      Position position,
      String newName,
      CancellationToken token);
}

/// Value-object describing what options formatting should use.
@anonymous
@JS()
abstract class FormattingOptions {
  /// Size of a tab in spaces.
  external num get tabSize;
  external set tabSize(num v);

  /// Prefer spaces over tabs.
  external bool get insertSpaces;
  external set insertSpaces(bool v);

  /// Signature for further properties.
  /* Index signature is not yet supported by JavaScript interop. */
}

/// The document formatting provider interface defines the contract between extensions and
/// the formatting-feature.
@anonymous
@JS()
abstract class DocumentFormattingEditProvider {
  /// Provide formatting edits for a whole document.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<TextEdit>|dynamic|Null|Thenable<List<TextEdit>|dynamic|Null>*/ provideDocumentFormattingEdits(
      TextDocument document,
      FormattingOptions options,
      CancellationToken token);
}

/// The document formatting provider interface defines the contract between extensions and
/// the formatting-feature.
@anonymous
@JS()
abstract class DocumentRangeFormattingEditProvider {
  /// Provide formatting edits for a range in a document.
  /// The given range is a hint and providers can decide to format a smaller
  /// or larger range. Often this is done by adjusting the start and end
  /// of the range to full syntax nodes.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<TextEdit>|dynamic|Null|Thenable<List<TextEdit>|dynamic|Null>*/ provideDocumentRangeFormattingEdits(
      TextDocument document,
      Range range,
      FormattingOptions options,
      CancellationToken token);
}

/// The document formatting provider interface defines the contract between extensions and
/// the formatting-feature.
@anonymous
@JS()
abstract class OnTypeFormattingEditProvider {
  /// Provide formatting edits after a character has been typed.
  /// The given position and character should hint to the provider
  /// what range the position to expand to, like find the matching `{`
  /// when `}` has been entered.
  /// signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<TextEdit>|dynamic|Null|Thenable<List<TextEdit>|dynamic|Null>*/ provideOnTypeFormattingEdits(
      TextDocument document,
      Position position,
      String ch,
      FormattingOptions options,
      CancellationToken token);
}

/// Represents a parameter of a callable-signature. A parameter can
/// have a label and a doc-comment.
@JS("vscode.ParameterInformation")
class ParameterInformation {
  // @Ignore
  ParameterInformation.fakeConstructor$();

  /// The label of this signature. Will be shown in
  /// the UI.
  external String get label;
  external set label(String v);

  /// The human-readable doc-comment of this signature. Will be shown
  /// in the UI but can be omitted.
  external String get documentation;
  external set documentation(String v);

  /// Creates a new parameter information object.
  external factory ParameterInformation(String label, [String documentation]);
}

/// Represents the signature of something callable. A signature
/// can have a label, like a function-name, a doc-comment, and
/// a set of parameters.
@JS("vscode.SignatureInformation")
class SignatureInformation {
  // @Ignore
  SignatureInformation.fakeConstructor$();

  /// The label of this signature. Will be shown in
  /// the UI.
  external String get label;
  external set label(String v);

  /// The human-readable doc-comment of this signature. Will be shown
  /// in the UI but can be omitted.
  external String get documentation;
  external set documentation(String v);

  /// The parameters of this signature.
  external List<ParameterInformation> get parameters;
  external set parameters(List<ParameterInformation> v);

  /// Creates a new signature information object.
  external factory SignatureInformation(String label, [String documentation]);
}

/// Signature help represents the signature of something
/// callable. There can be multiple signatures but only one
/// active and only one active parameter.
@JS("vscode.SignatureHelp")
class SignatureHelp {
  // @Ignore
  SignatureHelp.fakeConstructor$();

  /// One or more signatures.
  external List<SignatureInformation> get signatures;
  external set signatures(List<SignatureInformation> v);

  /// The active signature.
  external num get activeSignature;
  external set activeSignature(num v);

  /// The active parameter of the active signature.
  external num get activeParameter;
  external set activeParameter(num v);
}

/// The signature help provider interface defines the contract between extensions and
/// the [parameter hints](https://code.visualstudio.com/docs/editor/editingevolved#_parameter-hints)-feature.
@anonymous
@JS()
abstract class SignatureHelpProvider {
  /// Provide help for the signature at the given position and document.
  /// signaled by returning `undefined` or `null`.
  external dynamic /*SignatureHelp|dynamic|Null|Thenable<SignatureHelp|dynamic|Null>*/ provideSignatureHelp(
      TextDocument document, Position position, CancellationToken token);
}

/// Completion item kinds.
@JS("vscode.CompletionItemKind")
class CompletionItemKind {
  external static num get Text;
  external static num get Method;
  external static num get Function;
  external static num get Constructor;
  external static num get Field;
  external static num get Variable;
  external static num get Class;
  external static num get Interface;
  external static num get Module;
  external static num get Property;
  external static num get Unit;
  external static num get Value;
  external static num get Enum;
  external static num get Keyword;
  external static num get Snippet;
  external static num get Color;
  external static num get File;
  external static num get Reference;
}

/// A completion item represents a text snippet that is proposed to complete text that is being typed.
/// It is suffient to create a completion item from just a [label](#CompletionItem.label). In that
/// case the completion item will replace the [word](#TextDocument.getWordRangeAtPosition)
/// until the cursor with the given label or [insertText](#CompletionItem.insertText). Otherwise the
/// the given [edit](#CompletionItem.textEdit) is used.
/// When selecting a completion item in the editor its defined or synthesized text edit will be applied
/// to *all* cursors/selections whereas [additionalTextEdits](CompletionItem.additionalTextEdits) will be
/// applied as provided.
/// @see [CompletionItemProvider.provideCompletionItems](#CompletionItemProvider.provideCompletionItems)
/// @see [CompletionItemProvider.resolveCompletionItem](#CompletionItemProvider.resolveCompletionItem)
@JS("vscode.CompletionItem")
class CompletionItem {
  // @Ignore
  CompletionItem.fakeConstructor$();

  /// The label of this completion item. By default
  /// this is also the text that is inserted when selecting
  /// this completion.
  external String get label;
  external set label(String v);

  /// The kind of this completion item. Based on the kind
  /// an icon is chosen by the editor.
  external num /*enum CompletionItemKind*/ get kind;
  external set kind(num /*enum CompletionItemKind*/ v);

  /// A human-readable string with additional information
  /// about this item, like type or symbol information.
  external String get detail;
  external set detail(String v);

  /// A human-readable string that represents a doc-comment.
  external String get documentation;
  external set documentation(String v);

  /// A string that should be used when comparing this item
  /// with other items. When `falsy` the [label](#CompletionItem.label)
  /// is used.
  external String get sortText;
  external set sortText(String v);

  /// A string that should be used when filtering a set of
  /// completion items. When `falsy` the [label](#CompletionItem.label)
  /// is used.
  external String get filterText;
  external set filterText(String v);

  /// A string or snippet that should be inserted in a document when selecting
  /// this completion. When `falsy` the [label](#CompletionItem.label)
  /// is used.
  external dynamic /*String|SnippetString*/ get insertText;
  external set insertText(dynamic /*String|SnippetString*/ v);

  /// A range of text that should be replaced by this completion item.
  /// Defaults to a range from the start of the [current word](#TextDocument.getWordRangeAtPosition) to the
  /// current position.
  /// *Note:* The range must be a [single line](#Range.isSingleLine) and it must
  /// [contain](#Range.contains) the position at which completion has been [requested](#CompletionItemProvider.provideCompletionItems).
  external Range get range;
  external set range(Range v);

  /// **Deprecated** in favor of `CompletionItem.insertText` and `CompletionItem.range`.
  /// ~~An [edit](#TextEdit) which is applied to a document when selecting
  /// this completion. When an edit is provided the value of
  /// [insertText](#CompletionItem.insertText) is ignored.~~
  /// ~~The [range](#Range) of the edit must be single-line and on the same
  /// line completions were [requested](#CompletionItemProvider.provideCompletionItems) at.~~
  external TextEdit get textEdit;
  external set textEdit(TextEdit v);

  /// An optional array of additional [text edits](#TextEdit) that are applied when
  /// selecting this completion. Edits must not overlap with the main [edit](#CompletionItem.textEdit)
  /// nor with themselves.
  external List<TextEdit> get additionalTextEdits;
  external set additionalTextEdits(List<TextEdit> v);

  /// An optional [command](#Command) that is executed *after* inserting this completion. *Note* that
  /// additional modifications to the current document should be described with the
  /// [additionalTextEdits](#CompletionItem.additionalTextEdits)-property.
  external Command get command;
  external set command(Command v);

  /// Creates a new completion item.
  /// Completion items must have at least a [label](#CompletionItem.label) which then
  /// will be used as insert text as well as for sorting and filtering.
  external factory CompletionItem(String label,
      [num /*enum CompletionItemKind*/ kind]);
}

/// Represents a collection of [completion items](#CompletionItem) to be presented
/// in the editor.
@JS("vscode.CompletionList")
class CompletionList {
  // @Ignore
  CompletionList.fakeConstructor$();

  /// This list it not complete. Further typing should result in recomputing
  /// this list.
  external bool get isIncomplete;
  external set isIncomplete(bool v);

  /// The completion items.
  external List<CompletionItem> get items;
  external set items(List<CompletionItem> v);

  /// Creates a new completion list.
  external factory CompletionList(
      [List<CompletionItem> items, bool isIncomplete]);
}

/// The completion item provider interface defines the contract between extensions and
/// [IntelliSense](https://code.visualstudio.com/docs/editor/editingevolved#_intellisense).
/// When computing *complete* completion items is expensive, providers can optionally implement
/// the `resolveCompletionItem`-function. In that case it is enough to return completion
/// items with a [label](#CompletionItem.label) from the
/// [provideCompletionItems](#CompletionItemProvider.provideCompletionItems)-function. Subsequently,
/// when a completion item is shown in the UI and gains focus this provider is asked to resolve
/// the item, like adding [doc-comment](#CompletionItem.documentation) or [details](#CompletionItem.detail).
/// Providers are asked for completions either explicitly by a user gesture or -depending on the configuration-
/// implicitly when typing words or trigger characters.
@anonymous
@JS()
abstract class CompletionItemProvider {
  /// Provide completion items for the given position and document.
  /// The lack of a result can be signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<CompletionItem>|CompletionList|dynamic|Null|Thenable<List<CompletionItem>|CompletionList|dynamic|Null>*/ provideCompletionItems(
      TextDocument document, Position position, CancellationToken token);

  /// Given a completion item fill in more data, like [doc-comment](#CompletionItem.documentation)
  /// or [details](#CompletionItem.detail).
  /// The editor will only resolve a completion item once.
  /// `item`. When no result is returned, the given `item` will be used.
  external dynamic /*CompletionItem|dynamic|Null|Thenable<CompletionItem|dynamic|Null>*/ resolveCompletionItem(
      CompletionItem item, CancellationToken token);
}

/// A document link is a range in a text document that links to an internal or external resource, like another
/// text document or a web site.
@JS("vscode.DocumentLink")
class DocumentLink {
  // @Ignore
  DocumentLink.fakeConstructor$();

  /// The range this link applies to.
  external Range get range;
  external set range(Range v);

  /// The uri this link points to.
  external Uri get target;
  external set target(Uri v);

  /// Creates a new document link.
  external factory DocumentLink(Range range, [Uri target]);
}

/// The document link provider defines the contract between extensions and feature of showing
/// links in the editor.
@anonymous
@JS()
abstract class DocumentLinkProvider {
  /// Provide links for the given document. Note that the editor ships with a default provider that detects
  /// `http(s)` and `file` links.
  /// can be signaled by returning `undefined`, `null`, or an empty array.
  external dynamic /*List<DocumentLink>|dynamic|Null|Thenable<List<DocumentLink>|dynamic|Null>*/ provideDocumentLinks(
      TextDocument document, CancellationToken token);

  /// Given a link fill in its [target](#DocumentLink.target). This method is called when an incomplete
  /// link is selected in the UI. Providers can implement this method and return incomple links
  /// (without target) from the [`provideDocumentLinks`](#DocumentLinkProvider.provideDocumentLinks) method which
  /// often helps to improve performance.
  external dynamic /*DocumentLink|dynamic|Null|Thenable<DocumentLink|dynamic|Null>*/ resolveDocumentLink(
      DocumentLink link, CancellationToken token);
}

/// A tuple of two characters, like a pair of
/// opening and closing brackets.
/*export type CharacterPair = [string, string];*/
/// Describes how comments for a language work.
@anonymous
@JS()
abstract class CommentRule {
  /// The line comment token, like `// this is a comment`
  external String get lineComment;
  external set lineComment(String v);

  /// The block comment character pair, like `/* block comment *&#47;`
  external List<String> /*Tuple of <String,String>*/ get blockComment;
  external set blockComment(List<String> /*Tuple of <String,String>*/ v);
  external factory CommentRule(
      {String lineComment,
      List<String> /*Tuple of <String,String>*/ blockComment});
}

/// Describes indentation rules for a language.
@anonymous
@JS()
abstract class IndentationRule {
  /// If a line matches this pattern, then all the lines after it should be unindendented once (until another rule matches).
  external RegExp get decreaseIndentPattern;
  external set decreaseIndentPattern(RegExp v);

  /// If a line matches this pattern, then all the lines after it should be indented once (until another rule matches).
  external RegExp get increaseIndentPattern;
  external set increaseIndentPattern(RegExp v);

  /// If a line matches this pattern, then **only the next line** after it should be indented once.
  external RegExp get indentNextLinePattern;
  external set indentNextLinePattern(RegExp v);

  /// If a line matches this pattern, then its indentation should not be changed and it should not be evaluated against the other rules.
  external RegExp get unIndentedLinePattern;
  external set unIndentedLinePattern(RegExp v);
  external factory IndentationRule(
      {RegExp decreaseIndentPattern,
      RegExp increaseIndentPattern,
      RegExp indentNextLinePattern,
      RegExp unIndentedLinePattern});
}

/// Describes what to do with the indentation when pressing Enter.
@JS("vscode.IndentAction")
class IndentAction {
  external static num get

      /// Insert new line and copy the previous line's indentation.
      None;
  external static num get

      /// Insert new line and indent once (relative to the previous line's indentation).
      Indent;
  external static num get

      /// Insert two new lines:
      /// - the first one indented which will hold the cursor
      /// - the second one at the same indentation level
      IndentOutdent;
  external static num get

      /// Insert new line and outdent once (relative to the previous line's indentation).
      Outdent;
}

/// Describes what to do when pressing Enter.
@anonymous
@JS()
abstract class EnterAction {
  /// Describe what to do with the indentation.
  external num /*enum IndentAction*/ get indentAction;
  external set indentAction(num /*enum IndentAction*/ v);

  /// Describes text to be appended after the new line and after the indentation.
  external String get appendText;
  external set appendText(String v);

  /// Describes the number of characters to remove from the new line's indentation.
  external num get removeText;
  external set removeText(num v);
  external factory EnterAction(
      {num /*enum IndentAction*/ indentAction,
      String appendText,
      num removeText});
}

/// Describes a rule to be evaluated when pressing Enter.
@anonymous
@JS()
abstract class OnEnterRule {
  /// This rule will only execute if the text before the cursor matches this regular expression.
  external RegExp get beforeText;
  external set beforeText(RegExp v);

  /// This rule will only execute if the text after the cursor matches this regular expression.
  external RegExp get afterText;
  external set afterText(RegExp v);

  /// The action to execute.
  external EnterAction get action;
  external set action(EnterAction v);
  external factory OnEnterRule(
      {RegExp beforeText, RegExp afterText, EnterAction action});
}

/// The language configuration interfaces defines the contract between extensions
/// and various editor features, like automatic bracket insertion, automatic indentation etc.
@anonymous
@JS()
abstract class LanguageConfiguration {
  /// The language's comment settings.
  external CommentRule get comments;
  external set comments(CommentRule v);

  /// The language's brackets.
  /// This configuration implicitly affects pressing Enter around these brackets.
  external List<List<String> /*Tuple of <String,String>*/ > get brackets;
  external set brackets(List<List<String> /*Tuple of <String,String>*/ > v);

  /// The language's word definition.
  /// If the language supports Unicode identifiers (e.g. JavaScript), it is preferable
  /// to provide a word definition that uses exclusion of known separators.
  /// e.g.: A regex that matches anything except known separators (and dot is allowed to occur in a floating point number):
  /// /(-?\d*\.\d\w*)|([^\`\~\!\@\#\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g
  external RegExp get wordPattern;
  external set wordPattern(RegExp v);

  /// The language's indentation settings.
  external IndentationRule get indentationRules;
  external set indentationRules(IndentationRule v);

  /// The language's rules to be evaluated when pressing Enter.
  external List<OnEnterRule> get onEnterRules;
  external set onEnterRules(List<OnEnterRule> v);

  /// **Deprecated** Do not use.
  /// Will be replaced by a better API soon.
  external dynamic
      /*{
			/**
			 * This property is deprecated and will be **ignored** from
			 * the editor.
			 * @deprecated
			 */
			brackets?: any;
			/**
			 * This property is deprecated and not fully supported anymore by
			 * the editor (scope and lineStart are ignored).
			 * Use the the autoClosingPairs property in the language configuration file instead.
			 * @deprecated
			 */
			docComment?: {
				scope: string;
				open: string;
				lineStart: string;
				close?: string;
			};
		}*/
      get JS$___electricCharacterSupport;
  external set JS$___electricCharacterSupport(
      dynamic /*{
			/**
			 * This property is deprecated and will be **ignored** from
			 * the editor.
			 * @deprecated
			 */
			brackets?: any;
			/**
			 * This property is deprecated and not fully supported anymore by
			 * the editor (scope and lineStart are ignored).
			 * Use the the autoClosingPairs property in the language configuration file instead.
			 * @deprecated
			 */
			docComment?: {
				scope: string;
				open: string;
				lineStart: string;
				close?: string;
			};
		}*/
      v);

  /// **Deprecated** Do not use.
  /// * Use the the autoClosingPairs property in the language configuration file instead.
  external dynamic
      /*{
			autoClosingPairs: {
				open: string;
				close: string;
				notIn?: string[];
			}[];
		}*/
      get JS$___characterPairSupport;
  external set JS$___characterPairSupport(
      dynamic /*{
			autoClosingPairs: {
				open: string;
				close: string;
				notIn?: string[];
			}[];
		}*/
      v);
  external factory LanguageConfiguration(
      {CommentRule comments,
      List<List<String> /*Tuple of <String,String>*/ > brackets,
      RegExp wordPattern,
      IndentationRule indentationRules,
      List<OnEnterRule> onEnterRules,
      dynamic /*{
			/**
			 * This property is deprecated and will be **ignored** from
			 * the editor.
			 * @deprecated
			 */
			brackets?: any;
			/**
			 * This property is deprecated and not fully supported anymore by
			 * the editor (scope and lineStart are ignored).
			 * Use the the autoClosingPairs property in the language configuration file instead.
			 * @deprecated
			 */
			docComment?: {
				scope: string;
				open: string;
				lineStart: string;
				close?: string;
			};
		}*/
      JS$___electricCharacterSupport,
      dynamic /*{
			autoClosingPairs: {
				open: string;
				close: string;
				notIn?: string[];
			}[];
		}*/
      JS$___characterPairSupport});
}

/// Represents the workspace configuration.
/// The workspace configuration is a merged view: Configurations of the current [workspace](#workspace.rootPath)
/// (if available), files like `launch.json`, and the installation-wide configuration. Workspace specific values
/// shadow installation-wide values.
/// *Note:* The merged configuration of the current [workspace](#workspace.rootPath)
/// also contains settings from files like `launch.json` and `tasks.json`. Their basename will be
/// part of the section identifier. The following snippets shows how to retrieve all configurations
/// from `launch.json`:
/// ```
/// // launch.json configuration
/// const config = workspace.getConfiguration('launch');
/// // retrieve values
/// const values = config.get('configurations');
/// ```
@anonymous
@JS()
abstract class WorkspaceConfiguration {
  /// Return a value from this configuration.
  /*external T|dynamic JS$get<T>(String section);*/
  /// Return a value from this configuration.
  /*external T JS$get<T>(String section, T defaultValue);*/
  external dynamic /*T|dynamic*/ JS$get/*<T>*/(String section,
      [dynamic/*=T*/ defaultValue]);

  /// Check if this configuration has a certain value.
  external bool has(String section);

  /// Retrieve all information about a configuration setting. A configuration value
  /// often consists of a *default* value, a global or installation-wide value, and
  /// a workspace-specific value. The *effective* value (returned by [`get`](#WorkspaceConfiguration.get))
  /// is computed like this: `defaultValue` overwritten by `globalValue`,
  /// `globalValue` overwritten by `workspaceValue`.
  /// *Note:* The configuration name must denote a leaf in the configuration tree
  /// (`editor.fontSize` vs `editor`) otherwise no result is returned.
  external dynamic /*{ key: string; defaultValue?: T; globalValue?: T; workspaceValue?: T }|dynamic*/ inspect/*<T>*/(
      String section);

  /// Update a configuration value. A value can be changed for the current
  /// [workspace](#workspace.rootPath) only, or globally for all instances of the
  /// editor. The updated configuration values are persisted.
  /// *Note 1:* Setting an installation-wide value (`global: true`) in the presence of
  /// a more specific workspace value has no observable effect in that workspace, but
  /// in others.
  /// *Note 2:* To remove a configuration value use `undefined`, like so: `config.update('somekey', undefined)`
  external Thenable<Null> update(String section, dynamic value, [bool global]);

  /// Readable dictionary that backs this configuration.
  /// @readonly
  /* Index signature is not yet supported by JavaScript interop. */
}

/// Represents a location inside a resource, such as a line
/// inside a text file.
@JS("vscode.Location")
class Location {
  // @Ignore
  Location.fakeConstructor$();

  /// The resource identifier of this location.
  external Uri get uri;
  external set uri(Uri v);

  /// The document range of this locations.
  external Range get range;
  external set range(Range v);

  /// Creates a new location object.
  external factory Location(
      Uri uri, dynamic /*Range|Position*/ rangeOrPosition);
}

/// Represents the severity of diagnostics.
@JS("vscode.DiagnosticSeverity")
class DiagnosticSeverity {
  external static num get

      /// Something not allowed by the rules of a language or other means.
      Error;
  external static num get

      /// Something suspicious but allowed.
      Warning;
  external static num get

      /// Something to inform about but not a problem.
      Information;
  external static num get

      /// Something to hint to a better way of doing it, like proposing
      /// a refactoring.
      Hint;
}

/// Represents a diagnostic, such as a compiler error or warning. Diagnostic objects
/// are only valid in the scope of a file.
@JS("vscode.Diagnostic")
class Diagnostic {
  // @Ignore
  Diagnostic.fakeConstructor$();

  /// The range to which this diagnostic applies.
  external Range get range;
  external set range(Range v);

  /// The human-readable message.
  external String get message;
  external set message(String v);

  /// A human-readable string describing the source of this
  /// diagnostic, e.g. 'typescript' or 'super lint'.
  external String get source;
  external set source(String v);

  /// The severity, default is [error](#DiagnosticSeverity.Error).
  external num /*enum DiagnosticSeverity*/ get severity;
  external set severity(num /*enum DiagnosticSeverity*/ v);

  /// A code or identifier for this diagnostics. Will not be surfaced
  /// to the user, but should be used for later processing, e.g. when
  /// providing [code actions](#CodeActionContext).
  external dynamic /*String|num*/ get code;
  external set code(dynamic /*String|num*/ v);

  /// Creates a new diagnostic object.
  external factory Diagnostic(Range range, String message,
      [num /*enum DiagnosticSeverity*/ severity]);
}

/// A diagnostics collection is a container that manages a set of
/// [diagnostics](#Diagnostic). Diagnostics are always scopes to a
/// diagnostics collection and a resource.
/// To get an instance of a `DiagnosticCollection` use
/// [createDiagnosticCollection](#languages.createDiagnosticCollection).
@anonymous
@JS()
abstract class DiagnosticCollection {
  /// The name of this diagnostic collection, for instance `typescript`. Every diagnostic
  /// from this collection will be associated with this name. Also, the task framework uses this
  /// name when defining [problem matchers](https://code.visualstudio.com/docs/editor/tasks#_defining-a-problem-matcher).
  /// @readonly
  external String get name;
  external set name(String v);

  /// Assign diagnostics for given resource. Will replace
  /// existing diagnostics for that resource.
  /*external void JS$set(Uri uri, List<Diagnostic>|dynamic diagnostics);*/
  /// Replace all entries in this collection.
  /// Diagnostics of multiple tuples of the same uri will be merged, e.g
  /// `[[file1, [d1]], [file1, [d2]]]` is equivalent to `[[file1, [d1, d2]]]`.
  /// If a diagnostics item is `undefined` as in `[file1, undefined]`
  /// all previous but not subsequent diagnostics are removed.
  /*external void JS$set(List<Tuple of <Uri,List<Diagnostic>|dynamic>> entries);*/
  external void JS$set(
      dynamic /*Uri|List<Tuple of <Uri,List<Diagnostic>|dynamic>>*/ uri_entries,
      [dynamic /*List<Diagnostic>|dynamic*/ diagnostics]);

  /// Remove all diagnostics from this collection that belong
  /// to the provided `uri`. The same as `#set(uri, undefined)`.
  external void delete(Uri uri);

  /// Remove all diagnostics from this collection. The same
  /// as calling `#set(undefined)`;
  external void clear();

  /// Iterate over each entry in this collection.
  external void forEach(
      dynamic callback(Uri uri, List<Diagnostic> diagnostics,
          DiagnosticCollection collection),
      [dynamic thisArg]);

  /// Get the diagnostics for a given resource. *Note* that you cannot
  /// modify the diagnostics-array returned from this call.
  external dynamic /*List<Diagnostic>|dynamic*/ JS$get(Uri uri);

  /// Check if this collection contains diagnostics for a
  /// given resource.
  external bool has(Uri uri);

  /// Dispose and free associated resources. Calls
  /// [clear](#DiagnosticCollection.clear).
  external void dispose();
}

/// Denotes a column in the VS Code window. Columns are
/// used to show editors side by side.
@JS("vscode.ViewColumn")
class ViewColumn {
  external static num get One;
  external static num get Two;
  external static num get Three;
}

/// An output channel is a container for readonly textual information.
/// To get an instance of an `OutputChannel` use
/// [createOutputChannel](#window.createOutputChannel).
@anonymous
@JS()
abstract class OutputChannel {
  /// The human-readable name of this output channel.
  /// @readonly
  external String get name;
  external set name(String v);

  /// Append the given value to the channel.
  external void append(String value);

  /// Append the given value and a line feed character
  /// to the channel.
  external void appendLine(String value);

  /// Removes all output from the channel.
  external void clear();

  /// Reveal this channel in the UI.
  /*external void show([bool preserveFocus]);*/
  /// Reveal this channel in the UI.
  /// This method is **deprecated** and the overload with
  /// just one parameter should be used (`show(preserveFocus?: boolean): void`).
  /*external void show([enum ViewColumn column, bool preserveFocus]);*/
  external void show(
      [dynamic /*bool|enum ViewColumn*/ preserveFocus_column,
      bool preserveFocus]);

  /// Hide this channel from the UI.
  external void hide();

  /// Dispose and free associated resources.
  external void dispose();
}

/// Represents the alignment of status bar items.
@JS("vscode.StatusBarAlignment")
class StatusBarAlignment {
  external static num get

      /// Aligned to the left side.
      Left;
  external static num get

      /// Aligned to the right side.
      Right;
}

/// A status bar item is a status bar contribution that can
/// show text and icons and run a command on click.
@anonymous
@JS()
abstract class StatusBarItem {
  /// The alignment of this item.
  /// @readonly
  external num /*enum StatusBarAlignment*/ get alignment;
  external set alignment(num /*enum StatusBarAlignment*/ v);

  /// The priority of this item. Higher value means the item should
  /// be shown more to the left.
  /// @readonly
  external num get priority;
  external set priority(num v);

  /// The text to show for the entry. You can embed icons in the text by leveraging the syntax:
  /// `My text $(icon-name) contains icons like $(icon'name) this one.`
  /// Where the icon-name is taken from the [octicon](https://octicons.github.com) icon set, e.g.
  /// `light-bulb`, `thumbsup`, `zap` etc.
  external String get text;
  external set text(String v);

  /// The tooltip text when you hover over this entry.
  external String get tooltip;
  external set tooltip(String v);

  /// The foreground color for this entry.
  external String get color;
  external set color(String v);

  /// The identifier of a command to run on click. The command must be
  /// [known](#commands.getCommands).
  external String get command;
  external set command(String v);

  /// Shows the entry in the status bar.
  external void show();

  /// Hide the entry in the status bar.
  external void hide();

  /// Dispose and free associated resources. Call
  /// [hide](#StatusBarItem.hide).
  external void dispose();
}

/// An individual terminal instance within the integrated terminal.
@anonymous
@JS()
abstract class Terminal {
  /// The name of the terminal.
  /// @readonly
  external String get name;
  external set name(String v);

  /// The process ID of the shell process.
  /// @readonly
  external Thenable<num> get processId;
  external set processId(Thenable<num> v);

  /// Send text to the terminal. The text is written to the stdin of the underlying pty process
  /// (shell) of the terminal.
  /// required to run a command in the terminal. The character(s) added are \n or \r\n
  /// depending on the platform. This defaults to `true`.
  external void sendText(String text, [bool addNewLine]);

  /// Show the terminal panel and reveal this terminal in the UI.
  external void show([bool preserveFocus]);

  /// Hide the terminal panel if this terminal is currently showing.
  external void hide();

  /// Dispose and free associated resources.
  external void dispose();
}

/// Represents an extension.
/// To get an instance of an `Extension` use [getExtension](#extensions.getExtension).
@anonymous
@JS()
abstract class Extension<T> {
  /// The canonical extension identifier in the form of: `publisher.name`.
  /// @readonly
  external String get id;
  external set id(String v);

  /// The absolute file path of the directory containing this extension.
  /// @readonly
  external String get extensionPath;
  external set extensionPath(String v);

  /// `true` if the extension has been activated.
  /// @readonly
  external bool get isActive;
  external set isActive(bool v);

  /// The parsed contents of the extension's package.json.
  /// @readonly
  external dynamic get packageJSON;
  external set packageJSON(dynamic v);

  /// The public API exported by this extension. It is an invalid action
  /// to access this field before this extension has been activated.
  /// @readonly
  external T get exports;
  external set exports(T v);

  /// Activates this extension and returns its public API.
  external Thenable<T> activate();
}

/// An extension context is a collection of utilities private to an
/// extension.
/// An instance of an `ExtensionContext` is provided as the first
/// parameter to the `activate`-call of an extension.
@anonymous
@JS()
abstract class ExtensionContext {
  /// An array to which disposables can be added. When this
  /// extension is deactivated the disposables will be disposed.
  external List<dynamic /*{ dispose(): any }*/ > get subscriptions;
  external set subscriptions(List<dynamic /*{ dispose(): any }*/ > v);

  /// A memento object that stores state in the context
  /// of the currently opened [workspace](#workspace.rootPath).
  external Memento get workspaceState;
  external set workspaceState(Memento v);

  /// A memento object that stores state independent
  /// of the current opened [workspace](#workspace.rootPath).
  external Memento get globalState;
  external set globalState(Memento v);

  /// The absolute file path of the directory containing the extension.
  external String get extensionPath;
  external set extensionPath(String v);

  /// Get the absolute path of a resource contained in the extension.
  external String asAbsolutePath(String relativePath);

  /// An absolute file path of a workspace specific directory in which the extension
  /// can store private state. The directory might not exist on disk and creation is
  /// up to the extension. However, the parent directory is guaranteed to be existent.
  /// Use [`workspaceState`](#ExtensionContext.workspaceState) or
  /// [`globalState`](#ExtensionContext.globalState) to store key value data.
  external dynamic /*String|dynamic*/ get storagePath;
  external set storagePath(dynamic /*String|dynamic*/ v);
}

/// A memento represents a storage utility. It can store and retrieve
/// values.
@anonymous
@JS()
abstract class Memento {
  /// Return a value.
  /*external T|dynamic JS$get<T>(String key);*/
  /// Return a value.
  /// value (`undefined`) with the given key.
  /*external T JS$get<T>(String key, T defaultValue);*/
  external dynamic /*T|dynamic*/ JS$get/*<T>*/(String key,
      [dynamic/*=T*/ defaultValue]);

  /// Store a value. The value must be JSON-stringifyable.
  external Thenable<Null> update(String key, dynamic value);
}

/// Namespace describing the environment the editor runs in.

// Module env
/// The application name of the editor, like 'VS Code'.
/// @readonly
@JS("vscode.env.appName")
external String get appName;
@JS("vscode.env.appName")
external set appName(String v);

/// Represents the preferred user-language, like `de-CH`, `fr`, or `en-US`.
/// @readonly
@JS("vscode.env.language")
external String get language;
@JS("vscode.env.language")
external set language(String v);

/// A unique identifier for the computer.
/// @readonly
@JS("vscode.env.machineId")
external String get machineId;
@JS("vscode.env.machineId")
external set machineId(String v);

/// A unique identifier for the current session.
/// Changes each time the editor is started.
/// @readonly
@JS("vscode.env.sessionId")
external String get sessionId;
@JS("vscode.env.sessionId")
external set sessionId(String v);
// End module env
/// Namespace for dealing with commands. In short, a command is a function with a
/// unique identifier. The function is sometimes also called _command handler_.
/// Commands can be added to the editor using the [registerCommand](#commands.registerCommand)
/// and [registerTextEditorCommand](#commands.registerTextEditorCommand) functions. Commands
/// can be executed [manually](#commands.executeCommand) or from a UI gesture. Those are:
/// * palette - Use the `commands`-section in `package.json` to make a command show in
/// the [command palette](https://code.visualstudio.com/docs/editor/codebasics#_command-palette).
/// * keybinding - Use the `keybindings`-section in `package.json` to enable
/// [keybindings](https://code.visualstudio.com/docs/customization/keybindings#_customizing-shortcuts)
/// for your extension.
/// Commands from other extensions and from the editor itself are accessible to an extension. However,
/// when invoking an editor command not all argument types are supported.
/// This is a sample that registers a command handler and adds an entry for that command to the palette. First
/// register a command handler with the identfier `extension.sayHello`.
/// ```javascript
/// commands.registerCommand('extension.sayHello', () => {
/// window.showInformationMessage('Hello World!');
/// });
/// ```
/// Second, bind the command identfier to a title under which it will show in the palette (`package.json`).
/// ```json
/// {
/// "contributes": {
/// "commands": [{
/// "command": "extension.sayHello",
/// "title": "Hello World"
/// }]
/// }
/// ```

// Module commands
/// Registers a command that can be invoked via a keyboard shortcut,
/// a menu item, an action, or directly.
/// Registering a command with an existing command identifier twice
/// will cause an error.
@JS("vscode.commands.registerCommand")
external Disposable registerCommand(
    String command, Function /*(...args: any[]) => any*/ callback,
    [dynamic thisArg]);

/// Registers a text editor command that can be invoked via a keyboard shortcut,
/// a menu item, an action, or directly.
/// Text editor commands are different from ordinary [commands](#commands.registerCommand) as
/// they only execute when there is an active editor when the command is called. Also, the
/// command handler of an editor command has access to the active editor and to an
/// [edit](#TextEditorEdit)-builder.
@JS("vscode.commands.registerTextEditorCommand")
external Disposable registerTextEditorCommand(String command,
    Function /*(textEditor: TextEditor, edit: TextEditorEdit, ...args: any[]) => void*/ callback,
    [dynamic thisArg]);

/// Executes the command denoted by the given command identifier.
/// When executing an editor command not all types are allowed to
/// be passed as arguments. Allowed are the primitive types `string`, `boolean`,
/// `number`, `undefined`, and `null`, as well as classes defined in this API.
/// There are no restrictions when executing commands that have been contributed
/// by extensions.
/// the command handler function doesn't return anything.
@JS("vscode.commands.executeCommand")
external Thenable<dynamic /*T|dynamic*/ > executeCommand/*<T>*/(String command,
    [dynamic rest1,
    dynamic rest2,
    dynamic rest3,
    dynamic rest4,
    dynamic rest5]);

/// Retrieve the list of all available commands. Commands starting an underscore are
/// treated as internal commands.
@JS("vscode.commands.getCommands")
external Thenable<List<String>> getCommands([bool filterInternal]);
// End module commands
/// Namespace for dealing with the current window of the editor. That is visible
/// and active editors, as well as, UI elements to show messages, selections, and
/// asking for user input.

// Module window
/// The currently active editor or `undefined`. The active editor is the one
/// that currently has focus or, when none has focus, the one that has changed
/// input most recently.
@JS("vscode.window.activeTextEditor")
external dynamic /*TextEditor|dynamic*/ get activeTextEditor;
@JS("vscode.window.activeTextEditor")
external set activeTextEditor(dynamic /*TextEditor|dynamic*/ v);

/// The currently visible editors or an empty array.
@JS("vscode.window.visibleTextEditors")
external List<TextEditor> get visibleTextEditors;
@JS("vscode.window.visibleTextEditors")
external set visibleTextEditors(List<TextEditor> v);

/// An [event](#Event) which fires when the [active editor](#window.activeTextEditor)
/// has changed. *Note* that the event also fires when the active editor changes
/// to `undefined`.
@JS("vscode.window.onDidChangeActiveTextEditor")
external Event<TextEditor> get onDidChangeActiveTextEditor;

/// An [event](#Event) which fires when the array of [visible editors](#window.visibleTextEditors)
/// has changed.
@JS("vscode.window.onDidChangeVisibleTextEditors")
external Event<List<TextEditor>> get onDidChangeVisibleTextEditors;

/// An [event](#Event) which fires when the selection in an editor has changed.
@JS("vscode.window.onDidChangeTextEditorSelection")
external Event<TextEditorSelectionChangeEvent>
    get onDidChangeTextEditorSelection;

/// An [event](#Event) which fires when the options of an editor have changed.
@JS("vscode.window.onDidChangeTextEditorOptions")
external Event<TextEditorOptionsChangeEvent> get onDidChangeTextEditorOptions;

/// An [event](#Event) which fires when the view column of an editor has changed.
@JS("vscode.window.onDidChangeTextEditorViewColumn")
external Event<TextEditorViewColumnChangeEvent>
    get onDidChangeTextEditorViewColumn;

/// An [event](#Event) which fires when a terminal is disposed.
@JS("vscode.window.onDidCloseTerminal")
external Event<Terminal> get onDidCloseTerminal;

/// Show the given document in a text editor. A [column](#ViewColumn) can be provided
/// to control where the editor is being shown. Might change the [active editor](#window.activeTextEditor).
/// are adjusted to be __Min(column, columnCount + 1)__.
@JS("vscode.window.showTextDocument")
external Thenable<TextEditor> showTextDocument(TextDocument document,
    [num /*enum ViewColumn*/ column, bool preserveFocus]);

/// Create a TextEditorDecorationType that can be used to add decorations to text editors.
@JS("vscode.window.createTextEditorDecorationType")
external TextEditorDecorationType createTextEditorDecorationType(
    DecorationRenderOptions options);

/// Show an information message to users. Optionally provide an array of items which will be presented as
/// clickable buttons.
/*external Thenable<String|dynamic> showInformationMessage(String message, [String items1, String items2, String items3, String items4, String items5]);*/
/// Show an information message.
/// @see [showInformationMessage](#window.showInformationMessage)
/*external Thenable<T|dynamic> showInformationMessage<T extends MessageItem>(String message, [T items1, T items2, T items3, T items4, T items5]);*/
@JS("vscode.window.showInformationMessage")
external Thenable<dynamic> /*Thenable<String|dynamic>|Thenable<T|dynamic>*/ showInformationMessage/*<T extends MessageItem>*/(
    String message, List<dynamic> /*List<String>|List<T>*/ items);

/// Show a warning message.
/// @see [showInformationMessage](#window.showInformationMessage)
/*external Thenable<String|dynamic> showWarningMessage(String message, [String items1, String items2, String items3, String items4, String items5]);*/
/// Show a warning message.
/// @see [showInformationMessage](#window.showInformationMessage)
/*external Thenable<T|dynamic> showWarningMessage<T extends MessageItem>(String message, [T items1, T items2, T items3, T items4, T items5]);*/
@JS("vscode.window.showWarningMessage")
external Thenable<dynamic> /*Thenable<String|dynamic>|Thenable<T|dynamic>*/ showWarningMessage/*<T extends MessageItem>*/(
    String message, List<dynamic> /*List<String>|List<T>*/ items);

/// Show an error message.
/// @see [showInformationMessage](#window.showInformationMessage)
/*external Thenable<String|dynamic> showErrorMessage(String message, [String items1, String items2, String items3, String items4, String items5]);*/
/// Show an error message.
/// @see [showInformationMessage](#window.showInformationMessage)
/*external Thenable<T|dynamic> showErrorMessage<T extends MessageItem>(String message, [T items1, T items2, T items3, T items4, T items5]);*/
@JS("vscode.window.showErrorMessage")
external Thenable<dynamic> /*Thenable<String|dynamic>|Thenable<T|dynamic>*/ showErrorMessage/*<T extends MessageItem>*/(
    String message, List<dynamic> /*List<String>|List<T>*/ items);

/// Shows a selection list.
/*external Thenable<String|dynamic> showQuickPick(List<String>|Thenable<List<String>> items, [QuickPickOptions options, CancellationToken token]);*/
/// Shows a selection list.
/*external Thenable<T|dynamic> showQuickPick<T extends QuickPickItem>(List<T>|Thenable<List<T>> items, [QuickPickOptions options, CancellationToken token]);*/
@JS("vscode.window.showQuickPick")
external Thenable<dynamic> /*Thenable<String|dynamic>|Thenable<T|dynamic>*/ showQuickPick/*<T extends QuickPickItem>*/(
    dynamic /*List<String>|Thenable<List<String>>|List<T>|Thenable<List<T>>*/ items,
    [QuickPickOptions options,
    CancellationToken token]);

/// Opens an input box to ask the user for input.
/// The returned value will be `undefined` if the input box was canceled (e.g. pressing ESC). Otherwise the
/// returned value will be the string typed by the user or an empty string if the user did not type
/// anything but dismissed the input box with OK.
@JS("vscode.window.showInputBox")
external Thenable<dynamic /*String|dynamic*/ > showInputBox(
    [InputBoxOptions options, CancellationToken token]);

/// Create a new [output channel](#OutputChannel) with the given name.
@JS("vscode.window.createOutputChannel")
external OutputChannel createOutputChannel(String name);

/// Set a message to the status bar. This is a short hand for the more powerful
/// status bar [items](#window.createStatusBarItem).
/*external Disposable setStatusBarMessage(String text);*/
/// Set a message to the status bar. This is a short hand for the more powerful
/// status bar [items](#window.createStatusBarItem).
/*external Disposable setStatusBarMessage(String text, num hideAfterTimeout);*/
/// Set a message to the status bar. This is a short hand for the more powerful
/// status bar [items](#window.createStatusBarItem).
/*external Disposable setStatusBarMessage(
    String text, Thenable<dynamic> hideWhenDone);*/
@JS("vscode.window.setStatusBarMessage")
external Disposable setStatusBarMessage(String text,
    [dynamic /*num|Thenable<dynamic>*/ hideAfterTimeout_hideWhenDone]);

/// Creates a status bar [item](#StatusBarItem).
@JS("vscode.window.createStatusBarItem")
external StatusBarItem createStatusBarItem(
    [num /*enum StatusBarAlignment*/ alignment, num priority]);

/// Creates a [Terminal](#Terminal). The cwd of the terminal will be the workspace directory
/// if it exists, regardless of whether an explicit customStartPath setting exists.
@JS("vscode.window.createTerminal")
external Terminal createTerminal(
    [String name, String shellPath, List<String> shellArgs]);

// End module window
/// An event describing an individual change in the text of a [document](#TextDocument).
@anonymous
@JS()
abstract class TextDocumentContentChangeEvent {
  /// The range that got replaced.
  external Range get range;
  external set range(Range v);

  /// The length of the range that got replaced.
  external num get rangeLength;
  external set rangeLength(num v);

  /// The new text for the range.
  external String get text;
  external set text(String v);
  external factory TextDocumentContentChangeEvent(
      {Range range, num rangeLength, String text});
}

/// An event describing a transactional [document](#TextDocument) change.
@anonymous
@JS()
abstract class TextDocumentChangeEvent {
  /// The affected document.
  external TextDocument get document;
  external set document(TextDocument v);

  /// An array of content changes.
  external List<TextDocumentContentChangeEvent> get contentChanges;
  external set contentChanges(List<TextDocumentContentChangeEvent> v);
  external factory TextDocumentChangeEvent(
      {TextDocument document,
      List<TextDocumentContentChangeEvent> contentChanges});
}

/// Represents reasons why a text document is saved.
@JS("vscode.TextDocumentSaveReason")
class TextDocumentSaveReason {
  external static num get

      /// Manually triggered, e.g. by the user pressing save, by starting debugging,
      /// or by an API call.
      Manual;
  external static num get

      /// Automatic after a delay.
      AfterDelay;
  external static num get

      /// When the editor lost focus.
      FocusOut;
}

/// An event that is fired when a [document](#TextDocument) will be saved.
/// To make modifications to the document before it is being saved, call the
/// [`waitUntil`](#TextDocumentWillSaveEvent.waitUntil)-function with a thenable
/// that resolves to an array of [text edits](#TextEdit).
@anonymous
@JS()
abstract class TextDocumentWillSaveEvent {
  /// The document that will be saved.
  external TextDocument get document;
  external set document(TextDocument v);

  /// The reason why save was triggered.
  external num /*enum TextDocumentSaveReason*/ get reason;
  external set reason(num /*enum TextDocumentSaveReason*/ v);

  /// Allows to pause the event loop and to apply [pre-save-edits](#TextEdit).
  /// Edits of subsequent calls to this function will be applied in order. The
  /// edits will be *ignored* if concurrent modifications of the document happened.
  /// *Note:* This function can only be called during event dispatch and not
  /// in an asynchronous manner:
  /// ```ts
  /// workspace.onWillSaveTextDocument(event => {
  /// async, will *throw* an error
  /// setTimeout(() => event.waitUntil(promise));
  /// sync, OK
  /// event.waitUntil(promise);
  /// })
  /// ```
  /*external void waitUntil(Thenable<List<TextEdit>> thenable);*/
  /// Allows to pause the event loop until the provided thenable resolved.
  /// *Note:* This function can only be called during event dispatch.
  /*external void waitUntil(Thenable<dynamic> thenable);*/
  external void waitUntil(
      Thenable /*Thenable<List<TextEdit>>|Thenable<dynamic>*/ thenable);
}

/// Namespace for dealing with the current workspace. A workspace is the representation
/// of the folder that has been opened. There is no workspace when just a file but not a
/// folder has been opened.
/// The workspace offers support for [listening](#workspace.createFileSystemWatcher) to fs
/// events and for [finding](#workspace.findFiles) files. Both perform well and run _outside_
/// the editor-process so that they should be always used instead of nodejs-equivalents.

// Module workspace
/// Creates a file system watcher.
/// A glob pattern that filters the file events must be provided. Optionally, flags to ignore certain
/// kinds of events can be provided. To stop listening to events the watcher must be disposed.
@JS("vscode.workspace.createFileSystemWatcher")
external FileSystemWatcher createFileSystemWatcher(String globPattern,
    [bool ignoreCreateEvents,
    bool ignoreChangeEvents,
    bool ignoreDeleteEvents]);

/// The folder that is open in VS Code. `undefined` when no folder
/// has been opened.
/// @readonly
@JS("vscode.workspace.rootPath")
external dynamic /*String|dynamic*/ get rootPath;
@JS("vscode.workspace.rootPath")
external set rootPath(dynamic /*String|dynamic*/ v);

/// Returns a path that is relative to the workspace root.
/// When there is no [workspace root](#workspace.rootPath) or when the path
/// is not a child of that folder, the input is returned.
@JS("vscode.workspace.asRelativePath")
external String asRelativePath(dynamic /*String|Uri*/ pathOrUri);

/// Find files in the workspace.
/// @sample `findFiles('**∕*.js', '**∕node_modules∕**', 10)`
@JS("vscode.workspace.findFiles")
external Thenable<List<Uri>> findFiles(String include,
    [String exclude, num maxResults, CancellationToken token]);

/// Save all dirty files.
@JS("vscode.workspace.saveAll")
external Thenable<bool> saveAll([bool includeUntitled]);

/// Make changes to one or many resources as defined by the given
/// [workspace edit](#WorkspaceEdit).
/// When applying a workspace edit, the editor implements an 'all-or-nothing'-strategy,
/// that means failure to load one document or make changes to one document will cause
/// the edit to be rejected.
@JS("vscode.workspace.applyEdit")
external Thenable<bool> applyEdit(WorkspaceEdit edit);

/// All text documents currently known to the system.
/// @readonly
@JS("vscode.workspace.textDocuments")
external List<TextDocument> get textDocuments;
@JS("vscode.workspace.textDocuments")
external set textDocuments(List<TextDocument> v);

/// Opens the denoted document from disk. Will return early if the
/// document is already open, otherwise the document is loaded and the
/// [open document](#workspace.onDidOpenTextDocument)-event fires.
/// The document to open is denoted by the [uri](#Uri). Two schemes are supported:
/// file: A file on disk, will be rejected if the file does not exist or cannot be loaded, e.g. `file:///Users/frodo/r.ini`.
/// untitled: A new file that should be saved on disk, e.g. `untitled:c:\frodo\new.js`. The language will be derived from the file name.
/// Uris with other schemes will make this method return a rejected promise.
/*external Thenable<TextDocument> openTextDocument(Uri uri);*/
/// A short-hand for `openTextDocument(Uri.file(fileName))`.
/// @see [openTextDocument](#openTextDocument)
/*external Thenable<TextDocument> openTextDocument(String fileName);*/
@JS("vscode.workspace.openTextDocument")
external Thenable<TextDocument> openTextDocument(
    dynamic /*Uri|String*/ uri_fileName);

/// Register a text document content provider.
/// Only one provider can be registered per scheme.
@JS("vscode.workspace.registerTextDocumentContentProvider")
external Disposable registerTextDocumentContentProvider(
    String scheme, TextDocumentContentProvider provider);

/// An event that is emitted when a [text document](#TextDocument) is opened.
@JS("vscode.workspace.onDidOpenTextDocument")
external Event<TextDocument> get onDidOpenTextDocument;

/// An event that is emitted when a [text document](#TextDocument) is disposed.
@JS("vscode.workspace.onDidCloseTextDocument")
external Event<TextDocument> get onDidCloseTextDocument;

/// An event that is emitted when a [text document](#TextDocument) is changed.
@JS("vscode.workspace.onDidChangeTextDocument")
external Event<TextDocumentChangeEvent> get onDidChangeTextDocument;

/// An event that is emitted when a [text document](#TextDocument) will be saved to disk.
/// *Note 1:* Subscribers can delay saving by registering asynchronous work. For the sake of data integrity the editor
/// might save without firing this event. For instance when shutting down with dirty files.
/// *Note 2:* Subscribers are called sequentially and they can [delay](#TextDocumentWillSaveEvent.waitUntil) saving
/// by registering asynchronous work. Protection against misbehaving listeners is implemented as such:
/// * there is an overall time budget that all listeners share and if that is exhausted no further listener is called
/// * listeners that take a long time or produce errors frequently will not be called anymore
/// The current thresholds are 1.5 seconds as overall time budget and a listener can misbehave 3 times before being ignored.
@JS("vscode.workspace.onWillSaveTextDocument")
external Event<TextDocumentWillSaveEvent> get onWillSaveTextDocument;

/// An event that is emitted when a [text document](#TextDocument) is saved to disk.
@JS("vscode.workspace.onDidSaveTextDocument")
external Event<TextDocument> get onDidSaveTextDocument;

/// Get a configuration object.
/// When a section-identifier is provided only that part of the configuration
/// is returned. Dots in the section-identifier are interpreted as child-access,
/// like `{ myExt: { setting: { doIt: true }}}` and `getConfiguration('myExt.setting').get('doIt') === true`.
@JS("vscode.workspace.getConfiguration")
external WorkspaceConfiguration getConfiguration([String section]);

/// An event that is emitted when the [configuration](#WorkspaceConfiguration) changed.
@JS("vscode.workspace.onDidChangeConfiguration")
external Event<Null> get onDidChangeConfiguration;
// End module workspace
/// Namespace for participating in language-specific editor [features](https://code.visualstudio.com/docs/editor/editingevolved),
/// like IntelliSense, code actions, diagnostics etc.
/// Many programming languages exist and there is huge variety in syntaxes, semantics, and paradigms. Despite that, features
/// like automatic word-completion, code navigation, or code checking have become popular across different tools for different
/// programming languages.
/// The editor provides an API that makes it simple to provide such common features by having all UI and actions already in place and
/// by allowing you to participate by providing data only. For instance, to contribute a hover all you have to do is provide a function
/// that can be called with a [TextDocument](#TextDocument) and a [Position](#Position) returning hover info. The rest, like tracking the
/// mouse, positioning the hover, keeping the hover stable etc. is taken care of by the editor.
/// ```javascript
/// languages.registerHoverProvider('javascript', {
/// provideHover(document, position, token) {
/// return new Hover('I am a hover!');
/// }
/// });
/// ```
/// Registration is done using a [document selector](#DocumentSelector) which is either a language id, like `javascript` or
/// a more complex [filter](#DocumentFilter) like `{ language: 'typescript', scheme: 'file' }`. Matching a document against such
/// a selector will result in a [score](#languages.match) that is used to determine if and how a provider shall be used. When
/// scores are equal the provider that came last wins. For features that allow full arity, like [hover](#languages.registerHoverProvider),
/// the score is only checked to be `>0`, for other features, like [IntelliSense](#languages.registerCompletionItemProvider) the
/// score is used for determining the order in which providers are asked to participate.

// Module languages
/// Return the identifiers of all known languages.
@JS("vscode.languages.getLanguages")
external Thenable<List<String>> getLanguages();

/// Compute the match between a document [selector](#DocumentSelector) and a document. Values
/// greater than zero mean the selector matches the document. The more individual matches a selector
/// and a document have, the higher the score is. These are the abstract rules given a `selector`:
/// ```
/// (1) When selector is an array, return the maximum individual result.
/// (2) When selector is a string match that against the [languageId](#TextDocument.languageId).
/// (2.1) When both are equal score is `10`,
/// (2.2) When the selector is `*` score is `5`,
/// (2.3) Else score is `0`.
/// (3) When selector is a [filter](#DocumentFilter) return the maximum individual score given that each score is `>0`.
/// (3.1) When [language](#DocumentFilter.language) is set apply rules from #2, when `0` the total score is `0`.
/// (3.2) When [scheme](#DocumentFilter.scheme) is set and equals the [uri](#TextDocument.uri)-scheme score with `10`, else the total score is `0`.
/// (3.3) When [pattern](#DocumentFilter.pattern) is set
/// (3.3.1) pattern equals the [uri](#TextDocument.uri)-fsPath score with `10`,
/// (3.3.1) if the pattern matches as glob-pattern score with `5`,
/// (3.3.1) the total score is `0`
/// ```
@JS("vscode.languages.match")
external num match(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    TextDocument document);

/// Create a diagnostics collection.
@JS("vscode.languages.createDiagnosticCollection")
external DiagnosticCollection createDiagnosticCollection([String name]);

/// Register a completion provider.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and groups of equal score are sequentially asked for
/// completion items. The process stops when one or many providers of a group return a
/// result. A failing provider (rejected promise or exception) will not fail the whole
/// operation.
@JS("vscode.languages.registerCompletionItemProvider")
external Disposable registerCompletionItemProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    CompletionItemProvider provider,
    [String triggerCharacters1,
    String triggerCharacters2,
    String triggerCharacters3,
    String triggerCharacters4,
    String triggerCharacters5]);

/// Register a code action provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerCodeActionsProvider")
external Disposable registerCodeActionsProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    CodeActionProvider provider);

/// Register a code lens provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerCodeLensProvider")
external Disposable registerCodeLensProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    CodeLensProvider provider);

/// Register a definition provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerDefinitionProvider")
external Disposable registerDefinitionProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DefinitionProvider provider);

/// Register a hover provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerHoverProvider")
external Disposable registerHoverProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    HoverProvider provider);

/// Register a document highlight provider.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and groups sequentially asked for document highlights.
/// The process stops when a provider returns a `non-falsy` or `non-failure` result.
@JS("vscode.languages.registerDocumentHighlightProvider")
external Disposable registerDocumentHighlightProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DocumentHighlightProvider provider);

/// Register a document symbol provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerDocumentSymbolProvider")
external Disposable registerDocumentSymbolProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DocumentSymbolProvider provider);

/// Register a workspace symbol provider.
/// Multiple providers can be registered. In that case providers are asked in parallel and
/// the results are merged. A failing provider (rejected promise or exception) will not cause
/// a failure of the whole operation.
@JS("vscode.languages.registerWorkspaceSymbolProvider")
external Disposable registerWorkspaceSymbolProvider(
    WorkspaceSymbolProvider provider);

/// Register a reference provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerReferenceProvider")
external Disposable registerReferenceProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    ReferenceProvider provider);

/// Register a reference provider.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and the best-matching provider is used. Failure
/// of the selected provider will cause a failure of the whole operation.
@JS("vscode.languages.registerRenameProvider")
external Disposable registerRenameProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    RenameProvider provider);

/// Register a formatting provider for a document.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and the best-matching provider is used. Failure
/// of the selected provider will cause a failure of the whole operation.
@JS("vscode.languages.registerDocumentFormattingEditProvider")
external Disposable registerDocumentFormattingEditProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DocumentFormattingEditProvider provider);

/// Register a formatting provider for a document range.
/// *Note:* A document range provider is also a [document formatter](#DocumentFormattingEditProvider)
/// which means there is no need to [register](registerDocumentFormattingEditProvider) a document
/// formatter when also registering a range provider.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and the best-matching provider is used. Failure
/// of the selected provider will cause a failure of the whole operation.
@JS("vscode.languages.registerDocumentRangeFormattingEditProvider")
external Disposable registerDocumentRangeFormattingEditProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DocumentRangeFormattingEditProvider provider);

/// Register a formatting provider that works on type. The provider is active when the user enables the setting `editor.formatOnType`.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and the best-matching provider is used. Failure
/// of the selected provider will cause a failure of the whole operation.
@JS("vscode.languages.registerOnTypeFormattingEditProvider")
external Disposable registerOnTypeFormattingEditProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    OnTypeFormattingEditProvider provider,
    String firstTriggerCharacter,
    [String moreTriggerCharacter1,
    String moreTriggerCharacter2,
    String moreTriggerCharacter3,
    String moreTriggerCharacter4,
    String moreTriggerCharacter5]);

/// Register a signature help provider.
/// Multiple providers can be registered for a language. In that case providers are sorted
/// by their [score](#languages.match) and called sequentially until a provider returns a
/// valid result.
@JS("vscode.languages.registerSignatureHelpProvider")
external Disposable registerSignatureHelpProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    SignatureHelpProvider provider,
    [String triggerCharacters1,
    String triggerCharacters2,
    String triggerCharacters3,
    String triggerCharacters4,
    String triggerCharacters5]);

/// Register a document link provider.
/// Multiple providers can be registered for a language. In that case providers are asked in
/// parallel and the results are merged. A failing provider (rejected promise or exception) will
/// not cause a failure of the whole operation.
@JS("vscode.languages.registerDocumentLinkProvider")
external Disposable registerDocumentLinkProvider(
    dynamic /*String|DocumentFilter|List<String|DocumentFilter>*/ selector,
    DocumentLinkProvider provider);

/// Set a [language configuration](#LanguageConfiguration) for a language.
@JS("vscode.languages.setLanguageConfiguration")
external Disposable setLanguageConfiguration(
    String language, LanguageConfiguration configuration);
// End module languages
/// Namespace for dealing with installed extensions. Extensions are represented
/// by an [extension](#Extension)-interface which allows to reflect on them.
/// Extension writers can provide APIs to other extensions by returning their API public
/// surface from the `activate`-call.
/// ```javascript
/// export function activate(context: vscode.ExtensionContext) {
/// let api = {
/// sum(a, b) {
/// return a + b;
/// },
/// mul(a, b) {
/// return a * b;
/// }
/// };
/// // 'export' public api-surface
/// return api;
/// }
/// ```
/// When depending on the API of another extension add an `extensionDependency`-entry
/// to `package.json`, and use the [getExtension](#extensions.getExtension)-function
/// and the [exports](#Extension.exports)-property, like below:
/// ```javascript
/// let mathExt = extensions.getExtension('genius.math');
/// let importedApi = mathExt.exports;
/// console.log(importedApi.mul(42, 1));
/// ```

// Module extensions
/// Get an extension by its full identifier in the form of: `publisher.name`.
/*external Extension<dynamic>|dynamic getExtension(String extensionId);*/
/// Get an extension its full identifier in the form of: `publisher.name`.
/*external Extension<T>|dynamic getExtension<T>(String extensionId);*/
@JS("vscode.extensions.getExtension")
external dynamic /*Extension<dynamic>|dynamic|Extension<T>*/ getExtension/*<T>*/(
    String extensionId);

/// All extensions currently known to the system.
@JS("vscode.extensions.all")
external List<Extension<dynamic>> get all;
@JS("vscode.extensions.all")
external set all(List<Extension<dynamic>> v);
// End module extensions

// End module vscode

/// Thenable is a common denominator between ES6 promises, Q, jquery.Deferred, WinJS.Promise,
/// and others. This API makes no assumption about what promise libary is being used which
/// enables reusing existing code without migrating to a specific promise implementation. Still,
/// we recommend the use of native promises which are available in VS Code.
@anonymous
@JS()
abstract class Thenable<T> {
  /// Attaches callbacks for the resolution and/or rejection of the Promise.
  /*external Thenable<TResult> then<TResult>([TResult|Thenable<TResult> onfulfilled(T value), TResult|Thenable<TResult> onrejected(dynamic reason)]);*/
  /*external Thenable<TResult> then<TResult>([TResult|Thenable<TResult> onfulfilled(T value), void onrejected(dynamic reason)]);*/
  external Thenable<dynamic/*=TResult*/ > then/*<TResult>*/(
      [dynamic /*TResult|Thenable<TResult>*/ onfulfilled(T value),
      Function /*Func1<dynamic, TResult|Thenable<TResult>>|VoidFunc1<dynamic>*/ onrejected]);
}

