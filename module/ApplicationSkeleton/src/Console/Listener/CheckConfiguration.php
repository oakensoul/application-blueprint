<?php
/**
 *
 * @author Oakensoul (http://www.oakensoul.com/)
 * @link https://github.com/oakensoul/Cornerstone for the canonical source repository
 * @copyright Copyright (c) 2013 Robert Gunnar Johnson Jr.
 * @license http://opensource.org/licenses/BSD-2-Clause BSD-2-Clause
 * @package Cornerstone
 */
namespace ApplicationSkeleton\Console\Listener;

use Exception;
use Zend\EventManager;
use Zend\ServiceManager;
use Zend\Console\ColorInterface;
use Cornerstone\EventManager\Service;
use Cornerstone\EventManager\Console;
use Zend\Config\Config;
use Zend\Console\Response;

/**
 * This Listener is placed as an example of an implementation that you should provide
 * if your derived module requires any Configuration listeners.
 *
 * @author oakensoul
 */
class CheckConfiguration extends EventManager\AbstractListenerAggregate implements ServiceManager\ServiceLocatorAwareInterface
{

    protected $mServiceLocator;

    /**
     * {@inheritDoc}
     */
    public function attach (EventManager\EventManagerInterface $pEventManager)
    {
        $options = array ();
        $options[] = $this;
        $options[] = 'EventHandler';

        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_CHECK_CONFIGURATION, $options, 1);
        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_INITIALIZE, $options, 500);
    }

    public function EventHandler (Console\Event $pEvent)
    {
        try
        {
            $console = $this->getServiceLocator()->get('console');

            $config = $this->getServiceLocator()->get('Config');
            $config = new Config($config);

            if (true == $pEvent->getVerboseFlag())
            {
                $console->write(' --------------- ', ColorInterface::LIGHT_GREEN);
                $console->writeLine('-----------------------------------------------------------', ColorInterface::YELLOW);

                $console->write("      [Listener] ", ColorInterface::LIGHT_GREEN);
                $console->writeLine(__CLASS__, ColorInterface::YELLOW);

                $console->write(' --------------- ', ColorInterface::LIGHT_GREEN);
                $console->writeLine('-----------------------------------------------------------', ColorInterface::YELLOW);
            }
        }
        catch (Exception $e)
        {
            $response = new Response();
            $response->setErrorLevel(1);
            $response->setContent('Exception Encountered: ' . $e->getMessage());
            return $response;
        }
    }

    /**
     * Set service locator
     *
     * @param ServiceLocatorInterface $serviceLocator
     */
    public function setServiceLocator (ServiceManager\ServiceLocatorInterface $serviceLocator)
    {
        $this->mServiceLocator = $serviceLocator;
    }

    /**
     * Get service locator
     *
     * @return ServiceLocatorInterface
     */
    public function getServiceLocator ()
    {
        return $this->mServiceLocator;
    }
}