<?php

require_once 'AppKernel.php';
define('GAME', 'puyo');

class PuyoKernel extends AppKernel
{
    public function registerBundles()
    {
        $bundles = parent::registerBundles();
        $bundles[] = new Gamz\PuyoBundle\GamzPuyoBundle();

        return $bundles;
    }
}
