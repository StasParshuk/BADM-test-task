<?php

namespace App\Handler;

use App\Message\SampleMessage;
use Symfony\Component\Messenger\Handler\MessageHandlerInterface;

final class SampleMessageHandler implements MessageHandlerInterface
{
    public function __invoke(SampleMessage $message)
    {
        // magically invoked when an instance of SampleMessage is dispatched
        print_r('Handler handled the message!');
    }
}
