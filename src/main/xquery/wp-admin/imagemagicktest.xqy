(: CURRENTLY a STUB - TODO - need to see whether ML ImageMagick impl will work for media scaling :)

declare function local:scale-image($img as binary()) as binary()
{
  if (xdmp:binary-size($img) > $MAX-IMG-SIZE) then
    let $wand := magick:read-image(magick:wand(), $img)
    let $height := magick:get-image-height($wand)
    let $width := magick:get-image-width($wand)
    let $wand :=
      magick:scale-image(
        $wand,
        fn:min((fn:ceiling($width * $MAX-IMG-DIM div $height), $MAX-IMG-DIM)),
        fn:min((fn:ceiling($height * $MAX-IMG-DIM div $width), $MAX-IMG-DIM)))
    return magick:write-image($wand)
  else
    $img
};

magick:wand()