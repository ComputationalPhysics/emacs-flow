fs = require 'fs'
path = require 'path'
temp = require 'temp'

{WorkspaceView} = require 'atom'

helper = require './spec-helper'

describe 'Emacs Flow', ->
  [editor, buffer, filePath, editorView] = []

  beforeEach ->
    # directory = temp.mkdirSync()
    # atom.project.setPath(directory)
    # atom.workspaceView = new WorkspaceView()
    # atom.workspace = atom.workspaceView.getModel()

    waitsForPromise ->
      atom.packages.activatePackage('emacs-flow')

    waitsForPromise ->
      atom.packages.activatePackage('language-coffee-script')

    # runs ->
      # filePath = path.join(directory, 'emacs-flow.coffee')

    waitsForPromise ->
      atom.workspace.open(filePath).then (e) -> editor = e

    runs ->
      buffer = editor.getBuffer()
      editorView = atom.views.getView(editor)

  describe 'activation', ->
    it 'creates the command', ->
      expect(helper.hasCommand(editorView, 'emacs-flow:auto-indent')).toBeTruthy()

  describe 'deactivation', ->
    beforeEach ->
      atom.packages.deactivatePackage('emacs-flow')

    it 'removes the command', ->
      expect(helper.hasCommand(editorView, 'emacs-flow:auto-indent')).toBeFalsy()
