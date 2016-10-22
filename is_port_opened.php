<?php
    $port = getenv('QUERY_STRING');

    if (strlen($port) === 0)
        die('QUERY_STRING is empty');
    elseif ($port != (string)(int)($port))
        die('QUERY_STRING is not a number');
    else {
        $fp = fsockopen($_SERVER['REMOTE_ADDR'], $port, $errno, $errstr, 10);

        if ($fp) {
            echo "1";
            fclose($fp);
        } else {
            echo "0";
        }

        echo "\n";
    }
