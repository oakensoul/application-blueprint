<?php
/**
 *
 * @author Oakensoul (http://www.oakensoul.com/)
 * @link https://github.com/web-masons/application-blueprint for the canonical source repository
 * @copyright Copyright (c) 2013 Robert Gunnar Johnson Jr. and Project Contributors
 * http://opensource.org/licenses/Apache-2.0 Apache-2.0-Clause
 * @package Cornerstone
 */

/**
 * To add a new route...
 *
 * Note: The "home" route comes from the oakensoul/Cornerstone module
 *
 * @see https://github.com/oakensoul/Cornerstone http://framework.zend.com/manual/2.2/en/modules/zend.mvc.routing.html
 */
$router = array ();

/**
 * To add a new controller...
 *
 * http://framework.zend.com/manual/2.2/en/user-guide/routing-and-controllers.html
 */
$controllers = array (
    'invokables' => array (
        'Application\Controller\Index' => 'ApplicationBlueprint\Http\Controller\IndexController'
    )
);

/**
 * Working with Views
 *
 * http://framework.zend.com/manual/2.2/en/modules/zend.view.quick-start.html
 */
$view_manager = array (
    'template_map' => array (
        'application/index/index' => __DIR__ . '/../view/application/index/index.phtml'
    ),
    'template_path_stack' => array (
        __DIR__ . '/../view'
    )
);

$config = array ();
$config['router'] = $router;
$config['controllers'] = $controllers;
$config['view_manager'] = $view_manager;

return $config;
