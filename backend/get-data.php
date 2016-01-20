<?php
# relative path into `posters` directory from `public` directory
define('REL_POSTERS_PATH', './posters');
# path to file containing posters meta data
define('POSTERS_METAFILE_PATH', __DIR__.'/../public/posters/posters-meta.json');
# path to file containing titles data
define('POSTERS_TITLES_PATH', __DIR__.'/../public/user-data/titles.json');

function getUrlParameter($name) {
  return isset($_GET[$name]) ? $_GET[$name] : null;
}

function getFileContent($filename) {
  if(!file_exists($filename)) {
    throw new Exception('Unknown path to file: `'.$filename.'`');
  }

  $handle = fopen($filename, 'r');

  if($handle === FALSE) {
    throw new Exception('Cannot read file.');
  } else {
    $content = stream_get_contents($handle);
    fclose($handle);

    return $content;
  }
}

try{
  $type = getUrlParameter('type');

  switch ($type) {
    case 'posters':
      $posters = getFileContent(POSTERS_METAFILE_PATH);
      $data = json_decode($posters);

      foreach ($data as $key => $poster) {
        if(isset($poster->url)) {
          $poster->url = REL_POSTERS_PATH.'/'.$poster->url;
        }
      }

    break;

    case 'titles':
      $posterId = getUrlParameter('poster');

      if(!$posterId) { throw new Exception('Poster id not defined.'); }

      $postersTitles = getFileContent(POSTERS_TITLES_PATH);
      $postersTitles = json_decode($postersTitles, TRUE);

      if(isset($postersTitles[$posterId])) {
        $data = $postersTitles[$posterId];
      } else {
        throw new Exception('Poster titles not found.');
      }

    break;

    default:
      throw new Exception("Unknow data type to get: $type");
      break;
  }

  header('Content-Type: application/json');
  echo json_encode($data);

} catch(Exception $e) {
  header('HTTP', true, 500);
  echo($e->getMessage());
}
?>