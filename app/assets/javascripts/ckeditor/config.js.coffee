Spree.ready ($) ->
  CKEDITOR.editorConfig = (config) ->
    config.allowedContent = true

    config.filebrowserBrowseUrl          = "/ckeditor/attachment_files"
    config.filebrowserFlashBrowseUrl     = "/ckeditor/attachment_files"
    config.filebrowserFlashUploadUrl     = "/ckeditor/attachment_files"
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures"
    config.filebrowserImageBrowseUrl     = "/ckeditor/pictures"
    config.filebrowserImageUploadUrl     = "/ckeditor/pictures"
    config.filebrowserUploadUrl          = "/ckeditor/attachment_files"

    config.language_list = [ 'ru:Russian', 'en:English:' ]
