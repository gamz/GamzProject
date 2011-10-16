<?php

require_once 'AppKernel.php';
define('GAME', 'typefastr');

class TypefastrKernel extends AppKernel
{
    public function registerBundles()
    {
        $bundles = parent::registerBundles();
        $bundles[] = new Gamz\TypefastrBundle\GamzTypefastrBundle();

        return $bundles;
    }
}
