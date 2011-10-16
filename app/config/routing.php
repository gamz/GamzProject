<?php

use Symfony\Component\Routing\RouteCollection;

$collection = new RouteCollection();
$collection->addCollection($loader->import('routing.yml'));
$collection->addCollection($loader->import('@Gamz'.ucfirst(GAME).'Bundle/Resources/config/routing.yml'));

return $collection;
