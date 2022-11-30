; ハイパーリンクや画像を TSAttribute で色付けする
[
 (inline_link)
 (image)
] @attribute

; 引用箇所全体をコメントと同じ色にする
(block_quote) @comment

; H1 ヘッダのタイトルに下線を引く
(atx_heading
 (atx_h1_marker)
 (heading_content) @text.underline
 )

; 言語名指定のない fenced code block の中身を TSLiteral で色付け
(fenced_code_block
 .
 (code_fence_content) @text.literal)
