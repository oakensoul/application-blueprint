<?php
/**
 *
 * @author Oakensoul (http://www.oakensoul.com/)
 * @link https://github.com/oakensoul/Cornerstone for the canonical source repository
 * @copyright Copyright (c) 2013 Robert Gunnar Johnson Jr.
 * @license http://opensource.org/licenses/BSD-2-Clause BSD-2-Clause
 * @package Cornerstone
 */
namespace ApplicationSkeleton;

use Zend\Mvc\ModuleRouteListener;
use Zend\Mvc\MvcEvent;

class Module
{
    public function onBootstrap (MvcEvent $e)
    {
        $application = $e->getApplication();
        $service_manager = $application->getServiceManager();
        $event_manager = $application->getEventManager();
        $shared_manager = $event_manager->getSharedManager();

        /* allow controller short names in routing */
        $module_route_listener = new ModuleRouteListener();
        $module_route_listener->attach($event_manager);

        /* Cornerstone Application Event Manager */
        $cornerstone_event_manager = $service_manager->get('Application\EventManager');

        /* attach our CLI strategies */
        $service_manager->get('ApplicationSkeleton\Console\CheckConfiguration')->attach($cornerstone_event_manager);
        $service_manager->get('ApplicationSkeleton\Console\CheckIntegration')->attach($cornerstone_event_manager);
    }

    public function getConfig ()
    {
        return include __DIR__ . '/config/module.config.php';
    }

    public function getAutoloaderConfig ()
    {
        return array (
            'Zend\Loader\StandardAutoloader' => array (
                'namespaces' => array (
                    __NAMESPACE__ => __DIR__ . '/src/'
                )
            )
        );
    }

    public function getServiceConfig ()
    {
        $factories = array ();

        $invokables = array ();

        $invokables['ApplicationSkeleton\Console\CheckConfiguration'] = 'ApplicationSkeleton\Console\Listener\CheckConfiguration';
        $invokables['ApplicationSkeleton\Console\CheckIntegration'] = 'ApplicationSkeleton\Console\Listener\CheckIntegration';

        $service_config = array (
            'factories' => $factories,
            'invokables' => $invokables
        );

        return $service_config;
    }
}
