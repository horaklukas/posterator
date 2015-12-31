<?php
# relative path into `posters` directory from `public` directory
define('REL_POSTERS_PATH', './posters');
# path to file containing posters meta data
define('POSTERS_METAFILE_PATH', __DIR__.'/../public/posters/posters-meta.json');

function getFileContent($filename) {
  if(!file_exists($filename)) {
    throw new Exception('Unknown path to posters metafile: `'.$filename.'`');
  }

  $handle = fopen($filename, 'r');

  if($handle === FALSE) {
    throw new Exception('Cannot read posters metafile.');
  } else {
    $content = stream_get_contents($handle);
    fclose($handle);

    return $content;
  }
}

try{
  $posters = getFileContent(POSTERS_METAFILE_PATH);
  $posters = json_decode($posters);

  foreach ($posters as $key => $poster) {
    if(isset($poster->url)) {
      $poster->url = REL_POSTERS_PATH.'/'.$poster->url;
    }
  }

  header('Content-Type: application/json');
  echo json_encode($posters);

} catch(Exception $e) {
  header('HTTP', true, 500);
  echo($e->getMessage());
}
?>